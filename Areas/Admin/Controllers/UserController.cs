using DongThucVatQuangTri.Applications.UserManage;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using DongThucVatQuangTri.Applications.Enums;
using Microsoft.AspNetCore.Mvc.Rendering;
using DongThucVatQuangTri.Applications.Roles;
using DongThucVatQuangTri.Applications.GroupUsers;
using DongThucVatQuangTri.Models.Entities;
using Org.BouncyCastle.Asn1.Ocsp;
using Microsoft.AspNetCore.Identity.UI.Services;
using System.Text;

namespace DongThucVatQuangTri.Areas.Admin.Controllers
{
    [Area("admin")]
    public class UserController : BaseController
    {
        private readonly IUserService _userService;
        private readonly IManageRole _manageRole;
        private readonly IManageGroupUser _manageGroupUser;
        private readonly IEmailSender _emailSender;
        private readonly IWebHostEnvironment _env;
        public UserController(IUserService userService, IManageRole manageRole,IManageGroupUser manageGroupUser,  IEmailSender emailSender
        , IWebHostEnvironment env)
        {
            _userService = userService;
            _manageRole = manageRole;
            _manageGroupUser = manageGroupUser;
            _emailSender = emailSender;
            _env = env;
        }
        [Authorize(Policy = "AdministatorOrNationParkPolicy")]
        public async Task<IActionResult> Index(string keyword,string Roles, int PageIndex = 1, int PageSize = 10)
        {
            var request = new GetUserPagingRequest()
            {
                PageIndex = PageIndex,
                PageSize = PageSize,
                Keyword = keyword,
                Roles = Roles
            };
            var role = await _manageRole.getAll();
            ViewBag.Roles = role.Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Value.ToString(),
                Selected = x.Value == Roles
            });
            var RoleOfUser = User.FindFirstValue(ClaimTypes.Role);
            if(RoleOfUser!= "Administator")
            {
                request.Roles = RoleOfUser;
            }
            var data = await _userService.GetUserPaging(request);
            ViewBag.Keyword = keyword;
            if (TempData["result"] != null)
            {
                ViewBag.SuscessMsg = TempData["result"];
            }
            if (TempData["error"] != null)
            {
                ViewBag.ErrorMsg = TempData["error"];
            }
            return View(data.ResultObj);
        }
        [Authorize(Policy = "AdministratorPolicy")]
        public async Task<IActionResult> ChangePasswordList(string keyword, int PageIndex = 1, int PageSize = 10)
        {
            var request = new GetUserPagingRequest()
            {
                PageIndex = PageIndex,
                PageSize = PageSize,
                Keyword = keyword
            };
            var data = await _userService.GetUserPaging(request);
            ViewBag.Keyword = keyword;
            if (TempData["result"] != null)
            {
                ViewBag.SuscessMsg = TempData["result"];
            }
            return View(data.ResultObj);
        }
        [HttpGet]
        public IActionResult ChangePassword(Guid Id)
        {
            var newpass = new UpdatePasswordRequest()
            {
                Id = Id,
            };
            return View(newpass);
        }
        [HttpPost]
        public async Task<IActionResult> ChangePassword(UpdatePasswordRequest request)
        {
            if (!ModelState.IsValid)
                return View();
            var result = await _userService.ChangePassword(request.Id, request);
            if (result.IsSuccessed)
            {
                //TempData["result"] = "Đổi mật khẩu thành công";
                ViewBag.SuscessMsg = "Đổi mật khẩu thành công";
                return View(request);

            }
            ViewBag.ErrorMsg = result.Message;
            return View(request);
        }
        [HttpGet]
        [Authorize(Policy = "AdministratorPolicy")]
        public IActionResult AdminChangePassword(Guid Id)
        {
            var newpass = new AdminUpdatePasswordRequest()
            {
                Id = Id,
            };
            return View(newpass);
        }
        [HttpPost]
        [Authorize(Policy = "AdministratorPolicy")]
        public async Task<IActionResult> AdminChangePassword(AdminUpdatePasswordRequest request)
        {
            if (!ModelState.IsValid)
                return View();
            var result = await _userService.AdminChangePassword(request.Id, request);
            if (result.IsSuccessed)
            {
                TempData["result"] = "Thay đổi mật khẩu thành công";
                var loginUrl = Url.ActionLink("Index", "Login",null, Request.Scheme);
                var user =await _userService.GetById(request.Id);
                string template = $"<!doctype html>\r\n<html lang=\"en-US \">\r\n\r\n<head>\r\n  <meta content=\"text/html; charset=utf-8 \" http-equiv=\"Content-Type \" />\r\n  <title>Quên mật khẩu</title>\r\n  <meta name=\"description \" content=\"Reset Password Email Template. \">\r\n " +
                    " <style type=\"text/css \">\r\n    a:hover {\r\n\r\n      text-decoration: underline !important;\r\n\r\n    }\r\n  </style>\r\n</head>\r\n\r\n<body marginheight=\"0 \" topmargin=\"0 \" marginwidth=\"0 \" style=\"margin: 0px; background-color: #f2f3f8; \"\r\n  leftmargin=\"0 \">" +
                    $" <!--100% body table-->\r\n  <table cellspacing=\"0 \" border=\"0 \" cellpadding=\"0 \" width=\"100% \" bgcolor=\"#f2f3f8 \" style=\" @import\r\n    url(https://fonts.googleapis.com/css?family=Rubik:300,400,500,700|Open+Sans:300,400,600,700);\r\n    font-family: 'Open Sans' , sans-serif; \">" +
                    $"\r\n    <tr>\r\n      <td>\r\n        <table style=\"\r\n    background-color: #f2f3f8; max-width:670px; margin:0 auto; \" width=\" 100% \" border=\"\r\n    0 \" align=\" center \" cellpadding=\" 0 \" cellspacing=\"\r\n    0 \">\r\n          <tr>\r\n            <td style=\"\r\n    height:10px; \">" +
                    $"&nbsp;</td>\r\n          </tr>\r\n          <tr>\r\n            <td style=\"\r\n    text-align:center; font-weight: bold;font-size: 17px; \">\r\n              <div style=\"margin-top:5px ; \">CỤC LÂM NGHIỆP</div>\r\n              <div style=\"margin-top:5px ; \">BỘ NÔNG NGHIỆP VÀ PHÁT TRIỂN NÔNG THÔN</div>\r\n            </td>\r\n          </tr>\r\n          <tr>\r\n          " +
                    $"  <td style=\"height:20px; \">&nbsp;</td>\r\n          </tr>\r\n          <tr>\r\n            <td>\r\n              <table width=\"95% \" border=\"0 \" align=\"center \" cellpadding=\"0 \" cellspacing=\"0 \" style=\"max-width:670px;background:#fff; border-radius:3px; -webkit-box-shadow:0 6px 18px 0 rgba(0,0,0,.06);\r\n                 -moz-box-shadow:0 6px 18px 0 rgba(0,0,0,.06);box-shadow:0 6px 18px 0\r\n " +
                    $"               rgba(0,0,0,.06);text-align:center; \">\r\n                <tr>\r\n                  <td style=\"\r\n                height:40px; \">&nbsp;</td>\r\n                </tr>\r\n                <tr>\r\n                  <td style=\"\r\n                padding:0 35px; \">\r\n                    <h1 style=\" color:#1e1e2d; font-weight:500;\r\n               " +
                    $" margin:0;font-size:32px;font-family:'Rubik',sans-serif; text-align:center;\">Thông báo đổi mật khẩu</h1>\r\n                    <div style=\"text-align:center;\">\r\n                      <span style=\"\r\n                      display:inline-block; vertical-align:middle; margin:29px 0 26px; border-bottom:1px solid #cecece;\r\n                      width:100px;\"></span>\r\n   " +
                    $"                 </div>\r\n\r\n                    <p style=\"color:#455056; font-size:15px;line-height:24px; margin:0; \">\r\n                      Kính chào bạn <strong>{user.ResultObj.FirstName }</strong>\r\n                      <br>Mật khẩu của bạn đã được đổi thành: <strong>{request.NewPassword}</strong> bởi quản trị viên <strong>{User.FindFirstValue(ClaimTypes.GivenName)}</strong>\r\n                      <br>\r\n        " +
                    $"              Vui lòng đăng nhập để thiết lập mật khẩu mới!\r\n                    </p>\r\n                    <a href=\"{loginUrl} \"\r\n                      style=\"background:#20e277;text-decoration:none !important; font-weight:500; margin-top:35px; color:#fff;text-transform:uppercase; font-size:14px;padding:10px 24px;display:inline-block;border-radius:50px; \">Đăng\r\n  " +
                    $"                    nhập</a>\r\n                  </td>\r\n                </tr>\r\n                <tr>\r\n                  <td style=\"height:40px; \">&nbsp;</td>\r\n                </tr>\r\n              </table>\r\n            </td>\r\n        </table>\r\n      </td>\r\n    <tr>\r\n      <td style=\"height:20px; \">&nbsp;</td>\r\n    </tr>\r\n    </tr>\r\n  </table> <!--/100% body table-->\r\n</body>\r\n\r\n</html>";
                await _emailSender.SendEmailAsync(user.ResultObj.Email,"Đặt lại mật khẩu",template);
                return RedirectToAction("Index");
            }
            ViewBag.ErrorMsg = result.Message;
            return View(request);
        }
        [HttpGet]
        public async Task<IActionResult> ChangeRandomPassword(Guid id)
        {
            var newPassword = GeneratePassword(10);
            var request = new AdminUpdatePasswordRequest()
            {
                Id = id,
                NewPassword = newPassword,
                ConfirmPassword = newPassword
            };
            var result = await _userService.AdminChangePassword(id, request);
            if (result.IsSuccessed)
            {
                TempData["result"] = "Thay đổi mật khẩu thành công";
                var loginUrl = Url.ActionLink("Index", "Login", null, Request.Scheme);
                var user = await _userService.GetById(request.Id);
                string template = $"<!doctype html>\r\n<html lang=\"en-US \">\r\n\r\n<head>\r\n  <meta content=\"text/html; charset=utf-8 \" http-equiv=\"Content-Type \" />\r\n  <title>Quên mật khẩu</title>\r\n  <meta name=\"description \" content=\"Reset Password Email Template. \">\r\n " +
                    " <style type=\"text/css \">\r\n    a:hover {\r\n\r\n      text-decoration: underline !important;\r\n\r\n    }\r\n  </style>\r\n</head>\r\n\r\n<body marginheight=\"0 \" topmargin=\"0 \" marginwidth=\"0 \" style=\"margin: 0px; background-color: #f2f3f8; \"\r\n  leftmargin=\"0 \">" +
                    $" <!--100% body table-->\r\n  <table cellspacing=\"0 \" border=\"0 \" cellpadding=\"0 \" width=\"100% \" bgcolor=\"#f2f3f8 \" style=\" @import\r\n    url(https://fonts.googleapis.com/css?family=Rubik:300,400,500,700|Open+Sans:300,400,600,700);\r\n    font-family: 'Open Sans' , sans-serif; \">" +
                    $"\r\n    <tr>\r\n      <td>\r\n        <table style=\"\r\n    background-color: #f2f3f8; max-width:670px; margin:0 auto; \" width=\" 100% \" border=\"\r\n    0 \" align=\" center \" cellpadding=\" 0 \" cellspacing=\"\r\n    0 \">\r\n          <tr>\r\n            <td style=\"\r\n    height:10px; \">" +
                    $"&nbsp;</td>\r\n          </tr>\r\n          <tr>\r\n            <td style=\"\r\n    text-align:center; font-weight: bold;font-size: 17px; \">\r\n              <div style=\"margin-top:5px ; \">CỤC LÂM NGHIỆP</div>\r\n              <div style=\"margin-top:5px ; \">BỘ NÔNG NGHIỆP VÀ PHÁT TRIỂN NÔNG THÔN</div>\r\n            </td>\r\n          </tr>\r\n          <tr>\r\n          " +
                    $"  <td style=\"height:20px; \">&nbsp;</td>\r\n          </tr>\r\n          <tr>\r\n            <td>\r\n              <table width=\"95% \" border=\"0 \" align=\"center \" cellpadding=\"0 \" cellspacing=\"0 \" style=\"max-width:670px;background:#fff; border-radius:3px; -webkit-box-shadow:0 6px 18px 0 rgba(0,0,0,.06);\r\n                 -moz-box-shadow:0 6px 18px 0 rgba(0,0,0,.06);box-shadow:0 6px 18px 0\r\n " +
                    $"               rgba(0,0,0,.06);text-align:center; \">\r\n                <tr>\r\n                  <td style=\"\r\n                height:40px; \">&nbsp;</td>\r\n                </tr>\r\n                <tr>\r\n                  <td style=\"\r\n                padding:0 35px; \">\r\n                    <h1 style=\" color:#1e1e2d; font-weight:500;\r\n               " +
                    $" margin:0;font-size:32px;font-family:'Rubik',sans-serif; text-align:center;\">Thông báo đổi mật khẩu</h1>\r\n                    <div style=\"text-align:center;\">\r\n                      <span style=\"\r\n                      display:inline-block; vertical-align:middle; margin:29px 0 26px; border-bottom:1px solid #cecece;\r\n                      width:100px;\"></span>\r\n   " +
                    $"                 </div>\r\n\r\n                    <p style=\"color:#455056; font-size:15px;line-height:24px; margin:0; \">\r\n                      Kính chào bạn <strong>{user.ResultObj.FirstName}</strong>\r\n                      <br>Mật khẩu của bạn đã được đổi thành: <strong>{request.NewPassword}</strong> bởi quản trị viên <strong>{User.FindFirstValue(ClaimTypes.GivenName)}</strong>\r\n                      <br>\r\n        " +
                    $"              Vui lòng đăng nhập để thiết lập mật khẩu mới!\r\n                    </p>\r\n                    <a href=\"{loginUrl} \"\r\n                      style=\"background:#20e277;text-decoration:none !important; font-weight:500; margin-top:35px; color:#fff;text-transform:uppercase; font-size:14px;padding:10px 24px;display:inline-block;border-radius:50px; \">Đăng\r\n  " +
                    $"                    nhập</a>\r\n                  </td>\r\n                </tr>\r\n                <tr>\r\n                  <td style=\"height:40px; \">&nbsp;</td>\r\n                </tr>\r\n              </table>\r\n            </td>\r\n        </table>\r\n      </td>\r\n    <tr>\r\n      <td style=\"height:20px; \">&nbsp;</td>\r\n    </tr>\r\n    </tr>\r\n  </table> <!--/100% body table-->\r\n</body>\r\n\r\n</html>";
                await _emailSender.SendEmailAsync(user.ResultObj.Email, "Đặt lại mật khẩu", template);
                return RedirectToAction("Index");
            }
            ViewBag.ErrorMsg = result.Message;
            return RedirectToAction("AdminChangePassword", new { Id =id});
        }

        [HttpGet]
        [Authorize(Policy = "AdministratorPolicy")]
        public async Task<IActionResult> Create()
        {
            var role =await _manageRole.getAll();
            var groupUser =await _manageGroupUser.getAll();
            ViewBag.Roles = role.Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Value.ToString(),
            });
            ViewBag.GroupUser = groupUser.Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Id.ToString(),
            });
            return View();
        }
        [HttpPost]
        [Authorize(Policy = "AdministratorPolicy")]
        public async Task<IActionResult> Create(RegisterRequest request)
        {
            var role = await _manageRole.getAll();
            var groupUser = await _manageGroupUser.getAll();
            ViewBag.GroupUser = groupUser.Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Id.ToString(),
                Selected = request.GroupUserId == x.Id
            });
            ViewBag.Roles = role.Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Value.ToString(),
                Selected = request.Roles == x.Value
            });
            if (!ModelState.IsValid)
                return View();
            if (User.FindFirstValue(ClaimTypes.Role) != "Administator")
            {
                request.Roles = User.FindFirstValue(ClaimTypes.Role);
            } 
            var result = await _userService.Register(request);
            if (result.IsSuccessed)
            {
                TempData["result"] = "Thêm tài khoản thành công";

                return RedirectToAction("Index");
            }
            else
            {
                ViewBag.ErrorMsg  = result.Message;
            }
            return View(request);
        }
        [HttpPost]
        public async Task<IActionResult> Logout()
        {
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            HttpContext.Session.Remove("Token");
            return RedirectToAction("Index", "Home", new { area = "" } );
        }
        [HttpGet]
        
        public async Task<IActionResult> Edit(Guid id)
        {
            if(User.FindFirstValue(ClaimTypes.Role)!= "Administator" && User.FindFirstValue(ClaimTypes.NameIdentifier) != id.ToString())
            {
                TempData["error"] = "Bạn không được quyền chỉnh sửa";
                return RedirectToAction("Index");
            }
            var role = await _manageRole.getAll();
            ViewBag.Roles = role.Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Value.ToString(),
            });
            var groupUser = await _manageGroupUser.getAll();
            ViewBag.GroupUser = groupUser.Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Id.ToString(),
            });
            var result = await _userService.GetById(id);
            if (result.ResultObj.Roles == "Administator" && User.FindFirstValue(ClaimTypes.NameIdentifier) != result.ResultObj.Id.ToString())
            {
                TempData["error"] = "Bạn không được quyền chỉnh sửa";
                return RedirectToAction("Index");
            }
            if (result.IsSuccessed)
            {
                var user = result.ResultObj;
                var updateRequest = new UserUpdateRequest()
                {
                    Dob = user.Dob,
                    FirstName = user.FirstName,
                    Phone = user.Phone,
                    Id = id,
                    Gender = user.Gender,
                    Address = user.Address,
                    Roles = user.Roles,
                    GroupUserId = user.GroupUserId,
                    Status = Convert.ToInt16(user.Status.Contains("Kích hoạt") ? 1 : user.Status.Contains("Khóa") ? 0 : -1),
                };
                return View(updateRequest);
            }
            return RedirectToAction("Error", "Home");
        }
        [HttpPost]
        public async Task<IActionResult> Edit(UserUpdateRequest request)
        {
            var role = await _manageRole.getAll();
            ViewBag.Roles = role.Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Value.ToString(),
                Selected = x.Value == request.Roles
            });
            var groupUser = await _manageGroupUser.getAll();
            ViewBag.GroupUser = groupUser.Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Id.ToString(),
                Selected = x.Id == request.GroupUserId
            });
            if (!ModelState.IsValid)
                return View(request);

            var result = await _userService.Update(request.Id, request);
            if (result.IsSuccessed)
            {
               if( User.FindFirst(ClaimTypes.Role).Value== "Admin")
                {
                    return RedirectToAction("Details", new {id = request.Id});
                }
                TempData["result"] = "Cập nhật thông tin thành công";
                return RedirectToAction("Index");
            }
            ModelState.AddModelError("", result.Message);
            return View(request);
        }
        [HttpPost]
        [Authorize(Policy = "AdministratorPolicy")]
        public async Task<IActionResult> Delete(Guid Id)
        {
            if (!ModelState.IsValid)
                return RedirectToAction("Index");
            var user = await _userService.GetById(Id);
            if (user.ResultObj.Roles == "Administator" && User.FindFirstValue(ClaimTypes.NameIdentifier) != user.ResultObj.Id.ToString())
            {
                TempData["error"] = "Bạn không được quyền xóa";
                return RedirectToAction("Index");
            }
            var result = await _userService.delete(Id);
            if (result.IsSuccessed)
            {
                TempData["result"] = "Xóa tài khoản thành công";
                return RedirectToAction("Index");

            }
            TempData["error"] = "Xóa tài khoản không thành công";
            return RedirectToAction("Index");
        }
        [HttpGet]
        public async Task<IActionResult> Details(Guid Id)
        {
            var result = await _userService.GetById(Id);
            var groupUser =await _manageGroupUser.getAll();
            var user = result.ResultObj;
            //var role = result.ResultObj.Roles;
            //result.ResultObj.Roles = ;
            result.ResultObj.GroupUserName = groupUser.Where(x => x.Id == user.GroupUserId).Select(x=>x.Name).FirstOrDefault();
            return View(result.ResultObj);
        }
        public string GeneratePassword(int length)
        {
            if (length < 8)
            {
                throw new ArgumentException("Mật khẩu phải có độ dài ít nhất là 8 ký tự.");
            }

            const string lowerChars = "abcdefghijklmnopqrstuvwxyz";
            const string upperChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            const string digits = "0123456789";
            const string specialChars = "@#$%^&+=";
            const string allChars = lowerChars + upperChars + digits + specialChars;

            Random random = new Random();
            StringBuilder password = new StringBuilder();

            // Bảo đảm mật khẩu có ít nhất một ký tự chữ thường, chữ hoa, số và ký tự đặc biệt
            password.Append(lowerChars[random.Next(lowerChars.Length)]);
            password.Append(upperChars[random.Next(upperChars.Length)]);
            password.Append(digits[random.Next(digits.Length)]);
            password.Append(specialChars[random.Next(specialChars.Length)]);

            // Điền các ký tự ngẫu nhiên còn lại
            for (int i = 4; i < length; i++)
            {
                password.Append(allChars[random.Next(allChars.Length)]);
            }

            // Trộn mật khẩu để ngẫu nhiên hóa các ký tự
            return new string(password.ToString().OrderBy(c => random.Next()).ToArray());
        }
    }
}
