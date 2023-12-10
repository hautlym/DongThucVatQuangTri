using DongThucVatQuangTri.Applications.UserManage;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using DongThucVatQuangTri.Applications.Enums;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace DongThucVatQuangTri.Areas.Admin.Controllers
{
    [Area("admin")]
    

    public class UserController : BaseController
    {
        private readonly IUserService _userService;
        public UserController(IUserService userService)
        {
            _userService = userService;
        }
        [Authorize(Policy = "AdministratorPolicy")]
        public async Task<IActionResult> Index(string keyword, int PageIndex = 1, int PageSize = 10)
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
                return RedirectToAction("Index");

            }
            ViewBag.ErrorMsg = result.Message;
            return View(request);
        }
        [HttpGet]
        [Authorize(Policy = "AdministratorPolicy")]
        public IActionResult Create()
        {
            ViewBag.Roles = Permittion.Roles.Select(x => new SelectListItem()
            {
                Text = x.Value,
                Value = x.Key.ToString(),
            });
            return View();
        }
        [HttpPost]
        [Authorize(Policy = "AdministratorPolicy")]
        public async Task<IActionResult> Create(RegisterRequest request)
        {
            if (!ModelState.IsValid)
                return View();
            var result = await _userService.Register(request);
            if (result.IsSuccessed)
            {
                TempData["result"] = "Thêm tài khoản thành công";
                return RedirectToAction("Index");

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
            ViewBag.Roles = Permittion.Roles.Select(x => new SelectListItem()
            {
                Text = x.Value,
                Value = x.Key.ToString(),
            });
            var result = await _userService.GetById(id);
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
                    Status = Convert.ToInt16(user.Status.Contains("Kích hoạt") ? 1 : user.Status.Contains("Khóa") ? 0 : -1),
                };
                return View(updateRequest);
            }
            return RedirectToAction("Error", "Home");
        }
        [HttpPost]
        public async Task<IActionResult> Edit(UserUpdateRequest request)
        {
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
            var role = result.ResultObj.Roles;
            result.ResultObj.Roles = Permittion.Roles[role];
            return View(result.ResultObj);
        }
    }
}
