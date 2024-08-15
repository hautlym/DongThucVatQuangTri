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

namespace DongThucVatQuangTri.Areas.Admin.Controllers
{
    [Area("admin")]
    public class UserController : BaseController
    {
        private readonly IUserService _userService;
        private readonly IManageRole _manageRole;
        private readonly IManageGroupUser _manageGroupUser;
        public UserController(IUserService userService, IManageRole manageRole,IManageGroupUser manageGroupUser)
        {
            _userService = userService;
            _manageRole = manageRole;
            _manageGroupUser = manageGroupUser;
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
                return RedirectToAction("Index");

            }
            ViewBag.ErrorMsg = result.Message;
            return View(request);
        }
        [HttpGet]
        [Authorize(Policy = "AdministatorOrNationParkPolicy")]
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
        [Authorize(Policy = "AdministatorOrNationParkPolicy")]
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
            var role = result.ResultObj.Roles;
            result.ResultObj.Roles = Permittion.Roles[role];
            result.ResultObj.GroupUserName = groupUser.Where(x => x.Id == user.GroupUserId).Select(x=>x.Name).FirstOrDefault();
            return View(result.ResultObj);
        }
    }
}
