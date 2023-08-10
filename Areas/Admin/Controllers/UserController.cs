using DongThucVatQuangTri.Applications.UserManage;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

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
            var result = await _userService.ChangePassword(request.Id,request);
            if (result.IsSuccessed)
            {
                TempData["result"] = "Đổi mật khẩu thành công";
                return RedirectToAction("ChangePasswordList");

            }
            return View(request);
        }

        [HttpGet]
        public IActionResult Create()
        {
            return View();
        }
        [HttpPost]
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
            return RedirectToAction("Index", "Login");
        }
        [HttpGet]
        public async Task<IActionResult> Edit(Guid id)
        {
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
                    Status =Convert.ToInt16(user.Status.Contains("Kích hoạt")?1:user.Status.Contains("Khóa")?0:-1),
                };
                return View(updateRequest);
            }
            return RedirectToAction("Error", "Home");
        }
        [HttpPost]
        public async Task<IActionResult> Edit(UserUpdateRequest request)
        {
            if (!ModelState.IsValid)
                return View();

            var result = await _userService.Update(request.Id, request);
            if (result.IsSuccessed)
            {
                TempData["result"] = "Cập nhật thông tin thành công";
                return RedirectToAction("Index");

            }

            ModelState.AddModelError("", result.Message);
            return View(request);
        }
        [HttpPost]
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
            return View(result.ResultObj);
        }
    }
}
