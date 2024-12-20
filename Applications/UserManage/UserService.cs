﻿
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using DongThucVatQuangTri.Models.Entities;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.UI.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Infrastructure;
using Microsoft.AspNetCore.Mvc.Routing;
using Microsoft.AspNetCore.WebUtilities;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using Org.BouncyCastle.Asn1.Ocsp;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Net;
using System.Security.Claims;
using System.Security.Policy;
using System.Text;
using System.Threading.Tasks;

namespace DongThucVatQuangTri.Applications.UserManage
{
    public class UserService : IUserService
    {
        private readonly UserManager<AppUser> _userManager;
        private readonly SignInManager<AppUser> _signInManager;
        private readonly IConfiguration _config;
        //private readonly IActionContextAccessor _actionContextAccessor;
        //private readonly IUrlHelperFactory _urlHelperFactory;
        //private readonly IEmailSender _emailSender;
        public UserService(UserManager<AppUser> userManager, SignInManager<AppUser> signInManager, IConfiguration config
            )
        {
            _userManager = userManager;
            _signInManager = signInManager;
            _config = config;
            //_actionContextAccessor = actionContextAccessor;
            //_urlHelperFactory = urlHelperFactory;
            //_emailSender = emailSender;
        }

        public async Task<ApiResult<bool>> AdminChangePassword(Guid id, AdminUpdatePasswordRequest request)
        {
            var user = await _userManager.FindByIdAsync(id.ToString());
            if (user == null)
            {
                return new ApiErrorResult<bool>("Tài khoản không tồn tại");
            }
            user.UpdatedAt = DateTime.Now;
            var token = await _userManager.GeneratePasswordResetTokenAsync(user);
            var result = await _userManager.ResetPasswordAsync(user, token, request.NewPassword);
            if (result.Succeeded)
            {
                return new ApiSuccessResult<bool>();
            }

            return new ApiErrorResult<bool>("Cập nhật không thành công");
        }

        public async Task<ApiResult<string>> Authencate(LoginRequest request)
        {
            var user = await _userManager.FindByNameAsync(request.Username);
            if (user == null)
            {
                user = await _userManager.FindByEmailAsync(request.Username);
                if (user == null)
                {
                    return new ApiErrorResult<string>("Sai tài khoản hoặc mật khẩu");
                }
            }
          
            var result = await _signInManager.PasswordSignInAsync(user, request.Password, request.remember, true);
            if (!result.Succeeded)
            {
                if (result.IsLockedOut)
                {
                    return new ApiErrorResult<string>("Tài khoản của bạn đang bị khóa. Vui lòng liên hệ admin");
                }
                return new ApiErrorResult<string>("Sai tài khoản hoặc mật khẩu");
            }
            var claim = new[]
            {
                new Claim(ClaimTypes.Email, user.Email),
                new Claim(ClaimTypes.GivenName, user.FirstName),
                new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()),
                new Claim(ClaimTypes.Role, user.Roles),
                new Claim(ClaimTypes.UserData, user.Status.ToString())
            };
            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["Tokens:Key"]));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);
            CheckSignedTime(user.Id);
            var token = new JwtSecurityToken(_config["Tokens:Issuer"],
                _config["Tokens:Issuer"],
                claim,
                expires: DateTime.Now.AddHours(1),
                signingCredentials: creds);

            return new ApiSuccessResult<string>(new JwtSecurityTokenHandler().WriteToken(token));
        }

        public async Task<ApiResult<bool>> ChangePassword(Guid id, UpdatePasswordRequest request)
        {
            var user = await _userManager.FindByIdAsync(id.ToString());
            if (user == null)
            {
                return new ApiErrorResult<bool>("Tài khoản không tồn tại");
            }
            user.UpdatedAt = DateTime.Now;
            var result = await _userManager.ChangePasswordAsync(user, request.CurrentPassword, request.NewPassword);
            if (result.Succeeded)
            {
                return new ApiSuccessResult<bool>();
            }
            else
            {
                return new ApiErrorResult<bool>("Mật khẩu không chính xác");
            }

        }

        public async Task<ApiResult<bool>> CheckSignedTime(Guid id)
        {
            var user = await _userManager.FindByIdAsync(id.ToString());
            if (user == null)
            {
                return new ApiErrorResult<bool>("Tài khoản không tồn tại");
            }
            user.LastSigninedTime = DateTime.Now;
            try
            {
                var result = await _userManager.UpdateAsync(user);
                if (result.Succeeded)
                {
                    return new ApiSuccessResult<bool>();
                }
            }
            catch (Exception ex) { }

            return new ApiErrorResult<bool>("cập nhật không thành công");
        }

        public async Task<ApiResult<bool>> delete(Guid id)
        {
            var user = await _userManager.FindByIdAsync(id.ToString());
            if (user == null)
            {
                return new ApiErrorResult<bool>("User không tồn tại");
            }
            var reult = await _userManager.DeleteAsync(user);
            if (reult.Succeeded)
                return new ApiSuccessResult<bool>();

            return new ApiErrorResult<bool>("Xóa không thành công");
        }

        public async Task<ApiResult<UserViewModels>> GetById(Guid id)
        {
            var user = await _userManager.FindByIdAsync(id.ToString());
            if (user == null)
            {
                return new ApiErrorResult<UserViewModels>("User không tồn tại");
            }
            var userVm = new UserViewModels()
            {
                Address = user.Address,
                Gender = user.Gender,
                Id = user.Id,
                Avatar = user.Avatar,
                CreatedAt = user.CreatedAt,
                Dob = user.Dob,
                Email = user.Email,
                UpdatedAt = user.UpdatedAt,
                FirstName = user.FirstName,
                LastSigninedTime = user.LastSigninedTime,
                Status = user.Status == 1 ? "Kích hoạt" : user.Status == 0 ? "Khóa" : "None",
                Phone = user.PhoneNumber,
                Roles = user.Roles,
                GroupUserId = user.GroupUserId,
                
                
            };
            return new ApiSuccessResult<UserViewModels>(userVm);
        }

        public async Task<ApiResult<PageResult<UserViewModels>>> GetUserPaging(GetUserPagingRequest request)
        {
            var query = _userManager.Users;
            if (!string.IsNullOrEmpty(request.Keyword))
            {
                query = query.Where(x => x.UserName.Contains(request.Keyword)
                 || x.PhoneNumber.Contains(request.Keyword) || x.FirstName.Contains(request.Keyword));
            }
            if(!String.IsNullOrEmpty(request.Roles)) {
                query = query.Where(x=>x.Roles.Contains(request.Roles));
            }
            var totalRow = await query.CountAsync();
            var data = await query.Skip((request.PageIndex - 1) * request.PageSize).Take(request.PageSize).Select(
                user => new UserViewModels()
                {
                    Address = user.Address,
                    Gender = user.Gender,
                    Id = user.Id,
                    Avatar = user.Avatar,
                    CreatedAt = user.CreatedAt,
                    Dob = user.Dob,
                    Email = user.Email,
                    FirstName = user.FirstName,
                    LastSigninedTime = user.LastSigninedTime,
                    Status = user.Status == 1 ? "Kích hoạt" : user.Status == 0 ? "Khóa" : "None",
                    Phone = user.PhoneNumber,
                    GroupUserId = user.GroupUserId,
                }).ToListAsync();
            var PageResult = new PageResult<UserViewModels>()
            {
                TotalRecords = totalRow,
                Items = data,
                PageIndex = request.PageIndex,
                PageSize = request.PageSize,
            };
            return new ApiSuccessResult<PageResult<UserViewModels>>(PageResult);
        }
        public async Task<ApiResult<bool>> Register(RegisterRequest request)
        {

            if (await _userManager.FindByEmailAsync(request.Email) != null)
            {
                return new ApiErrorResult<bool>("Email đã tồn tại");
            }
            var user = new AppUser()
            {

                UserName = request.Email,
                Dob = request.Dob,
                Email = request.Email,
                FirstName = request.FirstName,
                PhoneNumber = request.PhoneNumber,
                Address = request.Address,
                Gender = request.Gender,
                CreatedAt = DateTime.Now,
                UpdatedAt = DateTime.Now,
                Avatar = request.Avatar,
                Status = request.Status,
                Roles = request.Roles,
                GroupUserId = request.GroupUserId,
                IsAdmin = request.Roles.Contains("Admin") ? Convert.ToInt16(1) : Convert.ToInt16(0),
            };
            var result = await _userManager.CreateAsync(user, request.Password);
            if (result.Succeeded)
            {
                //var token = await _userManager.GenerateEmailConfirmationTokenAsync(user);
                //token = WebEncoders.Base64UrlEncode(Encoding.UTF8.GetBytes(token));
                //ActionContext actionContext = _actionContextAccessor.ActionContext;
                //// Tạo IUrlHelper từ IUrlHelperFactory
                //IUrlHelper urlHelper = _urlHelperFactory.GetUrlHelper(actionContext);
                //string scheme = urlHelper.ActionContext.HttpContext.Request.Scheme;

                //// Tạo URL cho action "MyAction" trong controller "MyController"
                //var confirmationLink = urlHelper.Action("VerifyEmail", "Login", new { userId = user.Id, code = token }, scheme);
                //await _emailSender.SendEmailAsync(request.Email, "Xác thực Email", $"Hãy xác nhận địa chỉ email bằng cách <a href='{confirmationLink}'>Bấm vào đây</a>.");

                return new ApiSuccessResult<bool>();
            }
            return new ApiErrorResult<bool>("Đăng ký không thành công");
        }
        public async Task<ApiResult<bool>> Update(Guid id, UserUpdateRequest request)
        {

            var user = await _userManager.FindByIdAsync(id.ToString());
            if (user == null)
            {
                return new ApiErrorResult<bool>("Tài khoản không tồn tại");
            }
            user.Dob = request.Dob;
            user.FirstName = request.FirstName;
            user.PhoneNumber = request.Phone;
            user.Address = request.Address;
            user.Gender = request.Gender;
            user.Status = request.Status;
            user.UpdatedAt = DateTime.Now;
            user.Roles = request.Roles;
            user.GroupUserId = request.GroupUserId;
            var result = await _userManager.UpdateAsync(user);
            if (result.Succeeded)
            {
                return new ApiSuccessResult<bool>();
            }
            return new ApiErrorResult<bool>("cập nhật không thành công");
        }

    }
}
