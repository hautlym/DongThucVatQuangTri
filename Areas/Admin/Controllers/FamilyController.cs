using DongThucVatQuangTri.Applications.AnimalsAndPlant.ClassManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SetManage.Dtos;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SetManage;
using DongThucVatQuangTri.Applications.Banners.Dtos;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.FamilyManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.FamilyManage.Dtos;
using Microsoft.AspNetCore.Authorization;
using DongThucVatQuangTri.Applications.Common;

namespace DongThucVatQuangTri.Areas.Admin.Controllers
{
    [Area("admin")]
    [Authorize(Policy = "AdministatorOrNationParkPolicy")]
    public class FamilyController : BaseController
    {
        private readonly IManageSet _manageSet;
        private readonly IManageFamily _manageFamily;
        public FamilyController(IManageSet manageSet, IManageFamily manageFamily)
        {
            _manageSet = manageSet;
            _manageFamily = manageFamily;
        }
        public async Task<IActionResult> Index(int loai, string keyword = "", int PageIndex = 1, int PageSize = 10)
        {
            var request = new GetFamilyRequest()
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
            var ListItem = await _manageSet.getAllItem();
            ViewBag.Categories = ListItem.Where(x => x.Loai == loai).Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Id.ToString(),
            });
            var data = await _manageFamily.GetAlllPaging(request);
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
        public async Task<IActionResult> Create(int loai, CreateFamilyRequest request)
        {
            int LoaiDtv = loai;
            var ListItem = await _manageSet.getAllItem();
            ViewBag.Categories = ListItem.Where(x => x.Loai == loai).Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Id.ToString(),
            });
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
            var result = await _manageFamily.createItem(request);
            if (result == -2)
            {
                TempData["error"] = "Họ đã tồn tại";
                return RedirectToAction("Index", new { loai = LoaiDtv });
            }
            if (result > 0)
            {
                TempData["result"] = "Thêm thành công";
                return RedirectToAction("Index", new { loai = LoaiDtv });

            }
            TempData["error"] = "Thêm không thành công";
            return RedirectToAction("Index", new { loai = LoaiDtv });
        }

        [HttpPost]
        public async Task<IActionResult> Edit(int loai, UpdateFamilyRequest request)
        {
            int LoaiDtv = loai;
            var ListItem = await _manageSet.getAllItem();
            ViewBag.Categories = ListItem.Where(x => x.Loai == loai).Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Id.ToString(),
            });
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

            var result = await _manageFamily.updateItem(request);
            if (result == -2)
            {
                TempData["error"] = "Họ đã tồn tại";
                return RedirectToAction("Index", new { loai = LoaiDtv });

            }
            if (result > 0)
            {
                TempData["result"] = "Cập nhật thông tin thành công";
                return RedirectToAction("Index", new { loai = LoaiDtv });

            }

            TempData["error"] = "Cập nhật thông tin không thành công";
            return RedirectToAction("Index", new { loai = LoaiDtv });
        }
        [HttpPost]
        public async Task<IActionResult> Delete(int loai, int Id)
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
            var item = await _manageFamily.getItemById(Id);
            if (!HelperMethod.CheckUser(item.CreatedBy, User))
            {
                TempData["error"] = "Bạn không được quyền xóa";
                return RedirectToAction("Index", new { loai = item.Loai });
            }
            var result = await _manageFamily.deleteItem(Id);
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
            var item = await _manageFamily.getItemById(request.Id);
            if (!HelperMethod.CheckUser(item.CreatedBy, User))
            {
                return Json(new { success = false, message = "Bạn không có quyền thay đổi" });
            }
            var result = await _manageFamily.ChangeStatus(request);
            if (result > 0)
            {
                return Json(new { success = true, message = "Thuộc tính đã được thay đổi." });
            }
            return Json(new { success = true, message = "Thuộc tính không được thay đổi." });
        }
        [HttpGet]
        public async Task<IActionResult> Details(int Id)
        {
            var result = await _manageFamily.getItemById(Id);
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
