
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using DongThucVatQuangTri.Models.Entities;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Net;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace DongThucVatQuangTri.Applications.UserManage
{
    public class UserService : IUserService
    {
        private readonly UserManager<AppUser> _userManager;
        private readonly SignInManager<AppUser> _signInManager;
        private readonly IConfiguration _config;
        public UserService(UserManager<AppUser> userManager, SignInManager<AppUser> signInManager, IConfiguration config)
        {
            _userManager = userManager;
            _signInManager = signInManager;
            _config = config;
        }
        public async Task<ApiResult<string>> Authencate(LoginRequest request)
        {
            var user = await _userManager.FindByNameAsync(request.Username);
            if (user == null)
                return new ApiErrorResult<string>("Sai tài khoản hoặc mật khẩu");
            var result = await _signInManager.PasswordSignInAsync(user, request.Password, request.remember, true);
            if (!result.Succeeded)
            {
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

            var token = new JwtSecurityToken(_config["Tokens:Issuer"],
                _config["Tokens:Issuer"],
                claim,
                expires: DateTime.Now.AddHours(3),
                signingCredentials: creds);

            return new ApiSuccessResult<string>(new JwtSecurityTokenHandler().WriteToken(token));
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
                FirstName = user.FirstName,
                LastSigninedTime = user.LastSigninedTime,
                Status = user.Status==1?"Kích hoạt":user.Status==0?"Khóa":"None",
                Phone = user.PhoneNumber,
            };
            return new ApiSuccessResult<UserViewModels>(userVm);
        }

        public async Task<ApiResult<PageResult<UserViewModels>>> GetUserPaging(GetUserPagingRequest request)
        {
            var query = _userManager.Users;
            if (!string.IsNullOrEmpty(request.Keyword))
            {
                query = query.Where(x => x.UserName.Contains(request.Keyword)
                 || x.PhoneNumber.Contains(request.Keyword)||x.FirstName.Contains(request.Keyword));
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
                    Status = user.Status == 0 ? "Kích hoạt" : user.Status == 1 ? "Khóa" : "None",
                    Phone = user.PhoneNumber,
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
                IsAdmin = request.Roles.Contains("Admin")? Convert.ToInt16(1): Convert.ToInt16(0),
            };
            var result = await _userManager.CreateAsync(user, request.Password);
            if (result.Succeeded)
            {
                return new ApiSuccessResult<bool>();
            }
            return new ApiErrorResult<bool>("Đăng ký không thành công");
        }

        public async Task<ApiResult<bool>> RoleAssign(Guid id, RolesAssignRequest request)
        {
            var user = await _userManager.FindByIdAsync(id.ToString());
            if (user == null)
            {
                return new ApiErrorResult<bool>("Tài khoản không tồn tại");
            }
            var removedRoles = request.Roles.Where(x => x.Selected == false).Select(x => x.Name).ToList();
            foreach (var roleName in removedRoles)
            {
                var kq = await _userManager.IsInRoleAsync(user, roleName);
                if (kq)
                {
                    await _userManager.RemoveFromRoleAsync(user, roleName);
                }
            }
            //await _userManager.RemoveFromRolesAsync(user, removedRoles);

            var addedRoles = request.Roles.Where(x => x.Selected).Select(x => x.Name).ToList();
            foreach (var roleName in addedRoles)
            {
                if (await _userManager.IsInRoleAsync(user, roleName) == false)
                {
                    await _userManager.AddToRoleAsync(user, roleName);
                }
            }

            return new ApiSuccessResult<bool>();
        }

        public async Task<ApiResult<bool>> Update(Guid id, UserUpdateRequest request)
        {
            if (await _userManager.Users.AnyAsync(x => x.Email == request.Email && x.Id != id))
            {
                return new ApiErrorResult<bool>("emai đã tồn tại");
            }
            var user = await _userManager.FindByIdAsync(id.ToString());
            user.Dob = request.Dob;
            user.Email = request.Email;
            user.FirstName = request.FirstName;
            user.PhoneNumber = request.Phone;
            user.Address = request.Address;
            user.Gender = request.Gender;
            user.CitiesDistrictId = request.CitiesDistrictId;
            user.CitiesId = request.CitiesId;
            user.Id = request.Id;
            user.IsAdmin = request.IsAdmin;
            user.Avatar = request.Avatar;
            user.CreatedAt = request.CreatedAt;
            user.LastSigninedTime = request.LastSigninedTime;
            user.Status = request.Status;
            user.CreatedAt = request.CreatedAt;
            user.UpdatedAt=request.UpdatedAt;
            user.LastSigninedTime = request.LastSigninedTime;
            var result = await _userManager.UpdateAsync(user);
            if (result.Succeeded)
            {
                return new ApiSuccessResult<bool>();
            }
            return new ApiErrorResult<bool>("cập nhật không thành công");
        }

    }
}
