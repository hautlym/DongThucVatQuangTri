using DongThucVatQuangTri.Applications.Enums;
using DongThucVatQuangTri.Applications.GroupUsers;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.Security.Claims;
using DongThucVatQuangTri.Applications.GroupUsers.Dtos;

namespace DongThucVatQuangTri.Areas.Admin.Controllers
{
    [Area("admin")]
    [Authorize(Policy = "AdministratorPolicy")]
    public class GroupUserController : BaseController
    {
        private readonly IManageGroupUser _manageGroupUser;
        public GroupUserController(IManageGroupUser manageGroupUser)
        {
            _manageGroupUser = manageGroupUser;
        }
        public async Task<IActionResult> Index(string keyword, int PageIndex = 1, int PageSize = 10)
        {
            var request = new getGroupUserPaging()
            {
                PageIndex = PageIndex,
                PageSize = PageSize,
                Keyword = keyword,
            };
          
            var data = await _manageGroupUser.GetAlllPaging(request);
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
        public async Task<IActionResult> Create()
        {
            
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> Create(CreateGroupUserRequest request)
        {
            if (!ModelState.IsValid)
                return View();
            var result = await _manageGroupUser.Create(request);
            if (result>0)
            {
                TempData["result"] = "Thêm nhóm người dùng thành công";
                return RedirectToAction("Index");
            }
            else if(result ==-1)
            {
                TempData["error"] = "Nhóm người dùng đã tồn tại";
                return RedirectToAction("Index");
            }else
            {
                TempData["error"] = "Thêm nhóm người dùng không thành công";
                return RedirectToAction("Index");
            }
        }
     
        [HttpGet]

        public async Task<IActionResult> Edit(int id)
        {
           
            var result = await _manageGroupUser.getById(id);
            if (result!=null)
            {
                var updateRequest = new UpdateGroupUserRequest()
                {
                    Id = id,
                    Name = result.Name,
                };
                return View(updateRequest);
            }
            return RedirectToAction("Error", "Home");
        }
        [HttpPost]
        public async Task<IActionResult> Edit(UpdateGroupUserRequest request)
        {
            var role = await _manageGroupUser.getAll();
       
            if (!ModelState.IsValid)
                return View(request);

            var result = await _manageGroupUser.update( request);
            if (result>0)
            {
                TempData["result"] = "Cập nhật thông tin thành công";
                return RedirectToAction("Index");
            }
            else if(result==-2)
            {
                TempData["error"] = "Nhóm người dùng đã tồn tại";
                return RedirectToAction("Index");
            }
            else
            {
                TempData["error"] = "Cập nhật thông tin không thành công";
                return RedirectToAction("Index");
            }
        }
        [HttpPost]
        [Authorize(Policy = "AdministratorPolicy")]
        public async Task<IActionResult> Delete(int Id)
        {
            if (!ModelState.IsValid)
                return RedirectToAction("Index");

            var result = await _manageGroupUser.delete(Id);
            if (result>0)
            {
                TempData["result"] = "Xóa nhóm người dùng thành công";
                return RedirectToAction("Index");

            }
            TempData["error"] = "Xóa nhóm người dùng không thành công";
            return RedirectToAction("Index");
        }
        [HttpGet]
        public async Task<IActionResult> Details(int Id)
        {
            var result = await _manageGroupUser.getById(Id);
            return View(result);
        }
    }
}
