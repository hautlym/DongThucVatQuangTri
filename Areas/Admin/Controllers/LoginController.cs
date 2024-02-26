
using DongThucVatQuangTri.Applications.UserManage;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using DongThucVatQuangTri.Models.Entities;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.UI.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.WebUtilities;
using Microsoft.IdentityModel.Logging;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using static Org.BouncyCastle.Crypto.Engines.SM2Engine;

namespace DongThucVatQuangTri.Areas.Admin.Controllers
{
    [Area("admin")]
    [AllowAnonymous]
    public class LoginController : Controller
    {
        private readonly IUserService _userService;
        private readonly IConfiguration _configuration;
        private readonly UserManager<AppUser> _userManager;
        private readonly IEmailSender _emailSender;
        public LoginController(IConfiguration configuration, IUserService userService, IEmailSender emailService, UserManager<AppUser> userManager)
        {
            _configuration = configuration;
            _userService = userService;
            _emailSender = emailService;
            _userManager = userManager;
        }

        [HttpGet]
        public async Task<IActionResult> Index()
        {
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> Index(LoginRequest request)
        {
            if (!ModelState.IsValid)
            {
                ModelState.AddModelError("", "Vui lòng điền tài khoản hoặc mật khẩu");
                return View();
            }
            var token = await _userService.Authencate(request);
            if (token.ResultObj == null)
            {
                ModelState.AddModelError("", token.Message);
                return View();
            }
            var userPrincipal = this.ValidateToken(token.ResultObj);
            var kq = userPrincipal.FindFirst(ClaimTypes.Role).Value;
            var status = userPrincipal.FindFirst(ClaimTypes.UserData).Value;
            var UserId = userPrincipal.FindFirst(ClaimTypes.NameIdentifier).Value;
            if (kq.Contains("Member") || status.Contains("-1"))
            {
                ModelState.AddModelError("", "Tài khoản không tồn tại");
                return View();
            }

            if (!status.Contains("1"))
            {
                ModelState.AddModelError("", "Tài khoản đã bị khóa");
                return View();
            }
            var loginTime = _userService.CheckSignedTime(Guid.Parse(UserId));
            var authProperties = new AuthenticationProperties
            {
                ExpiresUtc = DateTimeOffset.UtcNow.AddHours(1),
                IsPersistent = true
            };
            HttpContext.Session.SetString("Token", token.ResultObj);
            await HttpContext.SignInAsync(
                       CookieAuthenticationDefaults.AuthenticationScheme,
                       userPrincipal,
                       authProperties);
            return RedirectToAction("Index", "Home");
        }
        private ClaimsPrincipal ValidateToken(string jwtToken)
        {
            IdentityModelEventSource.ShowPII = true;

            SecurityToken validatedToken;
            TokenValidationParameters validationParameters = new TokenValidationParameters();

            validationParameters.ValidateLifetime = true;

            validationParameters.ValidAudience = _configuration["Tokens:Issuer"];
            validationParameters.ValidIssuer = _configuration["Tokens:Issuer"];
            validationParameters.IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["Tokens:Key"]));

            ClaimsPrincipal principal = new JwtSecurityTokenHandler().ValidateToken(jwtToken, validationParameters, out validatedToken);

            return principal;
        }

        [HttpGet]
        public async Task<IActionResult> ForgetPassword()
        {
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> ForgetPassword(string email)
        {
            var user = await _userManager.FindByEmailAsync(email);
            if (!ModelState.IsValid)
            {
                ViewBag.ErrorForgotPass = "Vui lòng nhập email";
                return View();
            }
            //if(user==null ||!(await _userManager.IsEmailConfirmedAsync(user)))
            //{
            //    ViewBag.ErrorForgotPass = "Email chưa xác thực hoặc không tồn tại vui lòng liên hệ người quản lí";
            //    return View();
            //}
            if (user == null )
            {
                ViewBag.ErrorForgotPass = "người dùng không tồn tại vui lòng liên hệ người quản lí";
                return View();
            }
            var token = await _userManager.GeneratePasswordResetTokenAsync(user);
            token = WebEncoders.Base64UrlEncode(Encoding.UTF8.GetBytes(token));
            var confirmationLink = Url.Action("ResetPassword", "Login", new { userId = user.Id, code = token, Email = email }, Request.Scheme);
            await _emailSender.SendEmailAsync(email, "Quên mật khẩu ", $"Để đặt lại mật khẩu hãy <a href='{confirmationLink}'>Bấm vào đây</a>.");
            return RedirectToAction("NoticeEmail");
        }
        [HttpGet]
        public async Task<IActionResult> ResetPassword(string userId,string code,string Email)
        {
            var model = new ResetPasswordRequest()
            {
                UserId = userId,
                code = code,
                Email = Email
            };
            return View(model);
        }
        [HttpPost]
        public async Task<IActionResult> ResetPassword(ResetPasswordRequest request)
        {
            // Kiểm tra và xử lý reset password
            var user = await _userManager.FindByIdAsync(request.UserId);
            var newcode = Encoding.UTF8.GetString(WebEncoders.Base64UrlDecode(request.code));
            if (user != null)
            {
                var result = await _userManager.ResetPasswordAsync(user, newcode, request.NewPassword);
                if (result.Succeeded)
                {
                    TempData["result"] = "Đặt lại mật khẩu";
                    return RedirectToAction("NoticeResetPass");
                }
            }
            ModelState.AddModelError("", "Token không chính xác");
            return View();
        }
        [HttpGet()]
        public async Task<IActionResult> VerifyEmail(string userId, string code)
        {
            if (userId == null || code == null)
            {
                return BadRequest();
            }

            var user = await _userManager.FindByIdAsync(userId);
            if (user == null)
            {
                return BadRequest();
            }

            var decode = Encoding.UTF8.GetString(WebEncoders.Base64UrlDecode(code));
            var result = await _userManager.ConfirmEmailAsync(user, decode);
            if (result.Succeeded)
            {
                return View();
            }
            else
            {
                return BadRequest();
            }
        }
        [HttpGet]
        public async Task<IActionResult> NoticeEmail()
        {
           
            return View();
        }
        [HttpGet]
        public async Task<IActionResult> NoticeResetPass()
        {
            return View();
        }
    }
}
