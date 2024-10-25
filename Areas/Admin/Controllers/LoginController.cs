
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
using MimeKit;
using System.IdentityModel.Tokens.Jwt;
using System.Net.Mail;
using System.Net.Mime;
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
        private readonly IWebHostEnvironment _env;
        public LoginController(IConfiguration configuration, IUserService userService, IEmailSender emailService, 
            UserManager<AppUser> userManager, IWebHostEnvironment env)
        {
            _configuration = configuration;
            _userService = userService;
            _emailSender = emailService;
            _userManager = userManager;
            _env = env;
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
           
            var img = $"{Request.Scheme}://{Request.Host.Value}" + "/images/logo.png";

            var token = await _userManager.GeneratePasswordResetTokenAsync(user);
            token = WebEncoders.Base64UrlEncode(Encoding.UTF8.GetBytes(token));

           
            var confirmationLink = Url.Action("ResetPassword", "Login", new { userId = user.Id, code = token, Email = email }, Request.Scheme);
            string temapletHTML =
                $"\r\n<!doctype html>\r\n<html lang=\"en-US\">\r\n\r\n<head>\r\n    <meta content=\"text/html; charset=utf-8\" http-equiv=\"Content-Type\" />\r\n    <title>Quên mật khẩu</title>\r\n    <meta name=\"description\" content=\"Reset Password Email Template.\">\r\n    <style type=\"text/css\">\r\n        a:hover {{text-decoration: underline !important;}}\r\n    </style>\r\n</head>\r\n\r\n<body marginheight=\"0\" topmargin=\"0\" marginwidth=\"0\" style=\"margin: 0px; background-color: #f2f3f8;\" leftmargin=\"0\">\r\n    <!--100% body table-->\r\n    <table cellspacing=\"0\" border=\"0\" cellpadding=\"0\" width=\"100%\" bgcolor=\"#f2f3f8\"\r\n        " +
                $"style=\"@import url(https://fonts.googleapis.com/css?family=Rubik:300,400,500,700|Open+Sans:300,400,600,700); font-family: 'Open Sans', sans-serif;\">\r\n        <tr>\r\n            <td>\r\n                <table style=\"background-color: #f2f3f8; max-width:670px;  margin:0 auto;\" width=\"100%\" border=\"0\"\r\n                    align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\r\n                    <tr>\r\n                        <td style=\"height:10px;\">&nbsp;</td>\r\n                    </tr>\r\n                    <tr>\r\n                        <td style=\"text-align:center; font-weight: bold;font-size: 17px;\">\r\n                            " +
                $"\r\n                            <div style=\"margin-top:5px ;\">CỤC LÂM NGHIỆP</div>\r\n                            <div style=\"margin-top:5px ;\">BỘ NÔNG NGHIỆP VÀ PHÁT TRIỂN NÔNG THÔN</div>\r\n                        </td>\r\n                    </tr>\r\n                    <tr>\r\n                        <td style=\"height:20px;\">&nbsp;</td>\r\n                    </tr>\r\n                    <tr>\r\n                        <td>\r\n                            <table width=\"95%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\"\r\n                                style=\"max-width:670px;background:#fff; border-radius:3px; text-align:center;-webkit-box-shadow:0 6px 18px 0 rgba(0,0,0,.06);" +
                $"-moz-box-shadow:0 6px 18px 0 rgba(0,0,0,.06);box-shadow:0 6px 18px 0 rgba(0,0,0,.06);\">\r\n                                <tr>\r\n                                    <td style=\"height:40px;\">&nbsp;</td>\r\n                                </tr>\r\n                                <tr>\r\n                                    <td style=\"padding:0 35px;\">\r\n                                        <h1 style=\"color:#1e1e2d; font-weight:500; margin:0;font-size:32px;font-family:'Rubik',sans-serif;\">Bạn có yêu cầu đặt lại mật khẩu</h1>\r\n                                        <span\r\n                                            style=\"display:inline-block; vertical-align:middle; margin:29px 0 26px; border-bottom:1px solid #cecece; width:100px;\"></span>\r\n                    " +
                $"                    <p style=\"color:#455056; font-size:15px;line-height:24px; margin:0;\">\r\n                                            Chúng tôi không thể chỉ gửi cho bạn mật khẩu cũ của bạn. Một liên kết duy nhất để đặt lại mật khẩu đã được tạo cho bạn. Để đặt lại mật khẩu của bạn, hãy nhấp vào liên kết sau và làm theo hướng dẫn\r\n                                        </p>\r\n                                        <a href=\"{confirmationLink}\"\r\n                                            style=\"background:#20e277;text-decoration:none !important; font-weight:500; margin-top:35px; color:#fff;text-transform:uppercase; font-size:14px;padding:10px 24px;display:inline-block;border-radius:50px;\">Đặt lại mật khẩu</a>\r\n                                    </td>\r\n        " +
                $"       </tr>\r\n  <tr>\r\n   <td style=\"height:40px;\">&nbsp;</td>\r\n         </tr>\r\n                            </table>\r\n                        </td>\r\n                     </table>\r\n            </td>\r\n    <tr>\r\n                        <td style=\"height:20px;\">&nbsp;</td>\r\n                    </tr>\r\n                         </tr>\r\n    </table>\r\n    <!--/100% body table-->\r\n</body>\r\n\r\n</html>";


             _emailSender.SendEmailAsync(email, "Quên mật khẩu ", temapletHTML);
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
