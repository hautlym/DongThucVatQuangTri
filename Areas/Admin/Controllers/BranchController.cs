using DongThucVatQuangTri.Applications.NewsItem.Dtos.NewsCatDtos;
using DongThucVatQuangTri.Models.Entities;
using Microsoft.AspNetCore.Mvc;
using static Microsoft.Extensions.Logging.EventSource.LoggingEventSource;
using System.Drawing.Printing;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.BranchManage.Dtos;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.BranchManage;
using Microsoft.AspNetCore.Authorization;
using DongThucVatQuangTri.Applications.Banners.Dtos.BannerCategoryDtos;
using DongThucVatQuangTri.Applications.Banners.Dtos;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.Security.Claims;
using DongThucVatQuangTri.Applications.Common;

namespace DongThucVatQuangTri.Areas.Admin.Controllers
{
    [Area("admin")]
    [Authorize(Policy = "AdministatorOrNationParkPolicy")]
    public class BranchController : BaseController
    {
        private readonly IManageBranch _manageBranch;
        public BranchController(IManageBranch manageBranch)
        {
            _manageBranch = manageBranch;
        }
        [Authorize(Policy = "AdministatorOrNationParkPolicy")]
        public async Task<IActionResult> Index(int loai,string keyword="", int PageIndex = 1, int PageSize = 10)
        {
            var request = new GetBranchRequest()
            {
                PageIndex = PageIndex,
                PageSize = PageSize,
                keyword = keyword,
                loai = loai
            };
            if (loai == 1)
            {
                ViewBag.Loai = "Động Vật";
            }
            if (loai == 0)
            {
                ViewBag.Loai = "Thực vật";
            }
             
            var data = await _manageBranch.GetAlllPaging(request);
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
     
        [HttpPost]
        public async Task<IActionResult> Create(int loai,CreateBranchRequest request)
        {
            int LoaiDtv = loai;
            if (loai == 1)
            {
                ViewBag.Loai = "động vật";
            }
            if (loai == 0)
            {
                ViewBag.Loai = "thực vật";
            }
            if (!ModelState.IsValid)
                return View();
            request.CreatedBy = User.FindFirstValue(ClaimTypes.NameIdentifier);
            var result = await _manageBranch.createItem(request);
            if(result==-2)
            {
                TempData["error"] = "Ngành đã tồn tại";
                return RedirectToAction("Index", new { loai = LoaiDtv });
                
            }
            if (result > 0)
            {
                TempData["result"] = "Thêm thành công";
                return RedirectToAction("Index",new {loai = LoaiDtv } );
            }
            else
            {
                TempData["error"] = "Thêm mới không thành công";
                return RedirectToAction("Index", new { loai = LoaiDtv });
            }
            return View(request);
        }

      
        [HttpPost]
        public async Task<IActionResult> Edit(int loai,UpdateBranchRequest request)
        {
            int LoaiDtv = loai;
            if (loai == 1)
            {
                ViewBag.Loai = "động vật";
            }
            if (loai == 0)
            {
                ViewBag.Loai = "thực vật";
            }
            if (!ModelState.IsValid)
                return View();
            var item = await _manageBranch.getItemById((int)request.Id);
            if (!HelperMethod.CheckUser(item.CreatedBy, User))
            {
                TempData["error"] = "Bạn không được quyền chỉnh sửa";
                return RedirectToAction("Index", new { loai = item.Loai });
            }
            request.UpdatedBy = User.FindFirstValue(ClaimTypes.NameIdentifier);
            var result = await _manageBranch.updateItem(request);
            if (result == -2)
            {
                TempData["error"] = "Ngành đã tồn tại";
                return RedirectToAction("Index", new { loai = LoaiDtv });

            }
            if (result > 0)
            {
                TempData["result"] = "Cập nhật thông tin thành công";
                return RedirectToAction("Index", new { loai = LoaiDtv });
            }
            else
            {
                TempData["error"] = "Thêm mới không thành công";
                return RedirectToAction("Index", new { loai = LoaiDtv });
            }
          
        }
        [HttpPost]
        public async Task<IActionResult> Delete(int loai,int Id)
        {
            int LoaiDtv = loai;
            if (loai == 1)
            {
                ViewBag.Loai = "Động Vật";
            }
            if (loai == 0)
            {
                ViewBag.Loai = "Thực vật";
            }
            if (!ModelState.IsValid)
                return RedirectToAction("Index", new { loai = LoaiDtv });
            var item =await _manageBranch.getItemById(Id);
            if (!HelperMethod.CheckUser(item.CreatedBy, User))
            {
                TempData["error"] = "Bạn không được quyền xóa";
                return RedirectToAction("Index", new { loai = item.Loai });
            }

            var result = await _manageBranch.deleteItem(Id);
            if (result > 0)
            {
                TempData["result"] = "Xóa thành công";
                return RedirectToAction("Index", new { loai = LoaiDtv });

            }
            TempData["error"] = "Xóa không thành công";
            return RedirectToAction("Index", new { loai = LoaiDtv });
        }
        [HttpPost]
        public async Task<IActionResult> ChangeStatus(ChangeStatusRequest request)
        {
            var item =await _manageBranch.getItemById(request.Id);
            if (!HelperMethod.CheckUser(item.CreatedBy, User))
            {
                return Json(new { success = false, message = "Bạn không có quyền thay đổi" });
            }
            var result = await _manageBranch.ChangeStatus(request);
            if (result > 0)
            {
                return Json(new { success = true, message = "Thuộc tính đã được thay đổi." });
            }
            return Json(new { success = false, message = "Thuộc tính không được thay đổi." });
        }
        [HttpGet]
        public async Task<IActionResult> Details(int Id)
        {
            var result = await _manageBranch.getItemById(Id);
            var loai = result.Loai;
            if (loai == 1)
            {
                ViewBag.Loai = "Động Vật";
            }
            if (loai == 0)
            {
                ViewBag.Loai = "Thực vật";
            }
            return View(result);
        }
       
    }
}
