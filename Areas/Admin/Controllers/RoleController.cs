using DongThucVatQuangTri.Applications.NewsItem.Dtos.NewsDtos;
using DongThucVatQuangTri.Applications.Roles;
using DongThucVatQuangTri.Applications.Roles.Dtos;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using DongThucVatQuangTri.Models.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace DongThucVatQuangTri.Areas.Admin.Controllers
{
    [Area("admin")]
    [Authorize]
    public class RoleController : BaseController
    {
        private readonly IManageRole _manageRole;
        public RoleController(IManageRole manageRole)
        {
                _manageRole = manageRole;
        }
        public async Task<IActionResult> Index(string keyword, int PageIndex = 1, int PageSize = 10)
        {
            var request = new getRolePaging()
            {
                PageIndex = PageIndex,
                PageSize = PageSize,
                Keyword = keyword
            };
            var data = await _manageRole.getRolePaging(request);
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
        [HttpGet]
        public async Task<IActionResult> Edit(int Id)
        {
            var result = await _manageRole.getRoleById(Id);
            if(result == null)
            {
                TempData["error"] = "Không tìm thấy role";
                return RedirectToAction("Index");
            }

            if (result != null)
            {
                var updateRequest = new UpdateRoleRequest()
                {
                    Id = result.Id,
                    RoleName = result.Name
                };
                return View(updateRequest);
            }
            TempData["error"] = "Không tìm thấy role";
            return RedirectToAction("Index");
        }
        [HttpPost]
        public async Task<IActionResult> Edit(UpdateRoleRequest request)
        {
            if (!ModelState.IsValid)
                return View();
            var result = await _manageRole.UpdateRole(request);
            if(result<0)
            {
                if(result==-2)
                {
                    ModelState.AddModelError("RoleName", "Tên đã tồn tại");
                    return View();
                }
                TempData["error"] = "Sửa quyền không thành công";
                return RedirectToAction("Index");
            }
            else
            {
                TempData["result"] = "Sửa thành công";
                return RedirectToAction("Index");
            }
            
        }
    }
}
