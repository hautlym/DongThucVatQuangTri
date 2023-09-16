using DongThucVatQuangTri.Applications.AnimalsAndPlant.BranchManage.Dtos;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.BranchManage;
using DongThucVatQuangTri.Applications.Banners.Dtos;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.ClassManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.ClassManage.Dtos;
using DongThucVatQuangTri.Models.Entities;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace DongThucVatQuangTri.Areas.Admin.Controllers
{
    [Area("admin")]
    [Authorize(Policy = "AdministatorOrNationParkPolicy")]
    public class ClassController : BaseController
    {
        private readonly IManageBranch _manageBranch;
        private readonly IManageClass _manageClass;
        public ClassController(IManageBranch manageBranch, IManageClass manageClass)
        {
            _manageBranch = manageBranch;
            _manageClass = manageClass;
        }
        [Authorize(Policy = "AdministatorOrNationParkPolicy")]
        public async Task<IActionResult> Index(int loai, string keyword = "", int PageIndex = 1, int PageSize = 10)
        {
            var request = new GetClassRequest()
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

            var data = await _manageClass.GetAlllPaging(request);
            ViewBag.Keyword = keyword;
            if (TempData["result"] != null)
            {
                ViewBag.SuscessMsg = TempData["result"];
            }
            return View(data.ResultObj);
        }
        [HttpGet]
        [Authorize(Policy = "AdministratorPolicy")]

        public async Task<IActionResult> Create(int loai)
        {
            var ListBranch = await _manageBranch.getAllItem();
            ViewBag.Categories = ListBranch.Where(x=>x.Loai==loai).Select(x => new SelectListItem()
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
            return View();
        }
        [HttpPost]
        [Authorize(Policy = "AdministratorPolicy")]

        public async Task<IActionResult> Create(int loai, CreateClassRequest request)
        {
            int LoaiDtv = loai;
            var ListBranch = await _manageBranch.getAllItem();
            ViewBag.Categories = ListBranch.Where(x => x.Loai == loai).Select(x => new SelectListItem()
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
            var result = await _manageClass.createItem(request);
            if (result > 0)
            {
                TempData["result"] = "Thêm thành công";
                return RedirectToAction("Index", new { loai = LoaiDtv });

            }
            return View(request);
        }

        [HttpGet]
        [Authorize(Policy = "AdministratorPolicy")]

        public async Task<IActionResult> Edit(int id)
        {

            var result = await _manageClass.getItemById(id);
            var ListBranch = await _manageBranch.getAllItem();
            ViewBag.Categories = ListBranch.Where(x => x.Loai == result.Loai).Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Id.ToString(),
            });
            if (result.Loai == 1)
            {
                ViewBag.Loai = "Động Vật";
            }
            if (result.Loai == 0)
            {
                ViewBag.Loai = "Thực vật";
            }
            if (result != null)
            {
                var updateRequest = new UpdateClassRequest()
                {
                    Name = result.Name,
                    NameLatinh = result.NameLatinh,
                    Status = result.Status,
                    IdDtvNganh = result.IdDtvNganh,
                };
                return View(updateRequest);
            }
            return RedirectToAction("Error", "Home");
        }
        [HttpPost]
        [Authorize(Policy = "AdministratorPolicy")]

        public async Task<IActionResult> Edit(int loai, UpdateClassRequest request)
        {
            int LoaiDtv = loai;
            var ListBranch = await _manageBranch.getAllItem();
            ViewBag.Categories = ListBranch.Where(x => x.Loai == loai).Select(x => new SelectListItem()
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

            var result = await _manageClass.updateItem(request);
            if (result > 0)
            {
                TempData["result"] = "Cập nhật thông tin thành công";
                return RedirectToAction("Index", new { loai = LoaiDtv });

            }

            ModelState.AddModelError("", "Cập nhật không thành công");
            return View(request);
        }
        [HttpPost]
        [Authorize(Policy = "AdministratorPolicy")]

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

            var result = await _manageClass.deleteItem(Id);
            if (result > 0)
            {
                TempData["result"] = "Xóa  thành công";
                return RedirectToAction("Index", new { loai = LoaiDtv });

            }
            TempData["error"] = "Xóa không thành công";
            return RedirectToAction("Index", new { loai = LoaiDtv });
        }
        [HttpPost]
        [Authorize(Policy = "AdministratorPolicy")]

        public async Task<IActionResult> ChangeStatus(ChangeStatusRequest request)
        {
            var result = await _manageClass.ChangeStatus(request);
            if (result > 0)
            {
                return Json(new { success = true, message = "Thuộc tính đã được thay đổi." });
            }
            return Json(new { success = true, message = "Thuộc tính không được thay đổi." });
        }
        [HttpGet]
        public async Task<IActionResult> Details(int Id)
        {
            var result = await _manageClass.getItemById(Id);
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
