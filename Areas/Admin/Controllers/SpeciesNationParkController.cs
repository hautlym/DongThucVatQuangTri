using DongThucVatQuangTri.Applications.AnimalsAndPlant.SetManage.Dtos;
using DongThucVatQuangTri.Applications.Banners.Dtos;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.FamilyManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage.Dtos;
using DongThucVatQuangTri.Applications.Enums;
using System.Linq;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesNationParkManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesNationParkManage.Dtos;
using DongThucVatQuangTri.Applications.Common;
using System.Security.Claims;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.BranchManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.ClassManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SetManage;

namespace DongThucVatQuangTri.Areas.Admin.Controllers
{
    [Area("admin")]
    [Authorize(Policy = "AdministatorOrNationParkPolicy")]
    public class SpeciesNationParkController : BaseController
    {
        private readonly IManageSpecies _manageSpeciesGeneral;
        private readonly IManageSpeciesNationPark _manageSpecies;
        private readonly IManageBranch _manageBranch;
        private readonly IManageClass _manageClass;
        private readonly IManageSet _manageSet;
        private readonly IManageFamily _manageFamily;
        public SpeciesNationParkController(IManageSpecies manageSpeciesGeneral, IManageSpeciesNationPark manageSpecies,
           IManageBranch manageBranch, IManageClass manageClass, IManageSet manageSet, IManageFamily manageFamily)
        {
            _manageSpeciesGeneral = manageSpeciesGeneral;
            _manageSpecies = manageSpecies;
            _manageBranch = manageBranch;
            _manageClass = manageClass;
            _manageSet = manageSet;
            _manageFamily = manageFamily;
        }

        public async Task<IActionResult> Index(int loai, string keyword = "", int PageIndex = 1, int PageSize = 10)
        {
            var request = new getSpeciesNationParkRequest()
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

            var data = await _manageSpecies.GetAlllPaging(request);
            var role = User.FindFirstValue(ClaimTypes.Role);
            if (!User.FindFirstValue(ClaimTypes.Role).Contains("Administator"))
            {
                data.ResultObj.Items = data.ResultObj.Items.Where(x => x.TypeNationPark == role).ToList();
            }
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
        public async Task<IActionResult> Create(int loai)
        {
            var ListItem = await _manageSpeciesGeneral.getAllItem();
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
            return View();
        }
        [HttpPost]
        [Consumes("multipart/form-data")]
        public async Task<IActionResult> Create(int loai, [FromForm] CreateSpeciesNationParkRequest request)
        {
            int LoaiDtv = loai;
            var ListItem = await _manageSpeciesGeneral.getAllItem();
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
            if (request.IdDtvLoai == 0)
            {
                ModelState.AddModelError("", "Vui lòng chọn loài");
                return View();
            }
            
            var result = await _manageSpecies.createItem(request);
            if (result > 0)
            {
                TempData["result"] = "Thêm thành công";
                return RedirectToAction("Index", new { loai = LoaiDtv });

            }
            return View(request);
        }

        [HttpGet]
        public async Task<IActionResult> Edit(int id)
        {

            var result = await _manageSpecies.getItemById(id);
            if (!HelperMethod.CheckUser(result.CreatedBy, User))
            {
                TempData["error"] = "Bạn không được quyền chỉnh sửa";
                return RedirectToAction("Index", new { loai = result.Loai });
            }
            var ListItem = await _manageSpeciesGeneral.getAllItem();
            ViewBag.Categories = ListItem.Where(x => x.Loai == result.Loai).Select(x => new SelectListItem()
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
                var updateRequest = new UpdateSpeciesNationParkRequest()
                {

                    Status = result.Status,
                    IdDtvLoai = result.IdDtvLoai,
                    GiaTriSuDung = result.GiaTriSuDung,
                    DacDiem = result.DacDiem,
                    Loai = result.Loai,
                    PhanBo = result.PhanBo,
                    HinhAnh = result.FileDinhKem,
                    KinhDo = result.KinhDo,
                    ViDo = result.ViDo,
                    TenKhac = result.TenKhac,
                    TypeNationPark = result.TypeNationPark,
                    Id = (int)result.Id,
                };
                return View(updateRequest);
            }
            return RedirectToAction("Error", "Home");
        }
        [HttpPost]
        [Consumes("multipart/form-data")]
        public async Task<IActionResult> Edit(int loai, [FromForm] UpdateSpeciesNationParkRequest request)
        {
            int LoaiDtv = loai;
            var ListItem = await _manageSpeciesGeneral.getAllItem();
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

            var result = await _manageSpecies.updateItem(request);
            if (result > 0)
            {
                TempData["result"] = "Cập nhật thông tin thành công";
                return RedirectToAction("Index", new { loai = LoaiDtv });

            }

            ModelState.AddModelError("", "Cập nhật không thành công");
            return View(request);
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
            var item = await _manageSpecies.getItemById(Id);
            if (!HelperMethod.CheckUser(item.CreatedBy, User))
            {
                TempData["error"] = "Bạn không được quyền xóa";
                return RedirectToAction("Index", new { loai = item.Loai });
            }
            var result = await _manageSpecies.deleteItem(Id);
            if (result > 0)
            {
                TempData["result"] = "Xóa  thành công";
                return RedirectToAction("Index", new { loai = LoaiDtv });

            }
            TempData["error"] = "Xóa không thành công";
            return RedirectToAction("Index", new { loai = LoaiDtv });
        }
        [HttpPost]
        public async Task<IActionResult> ChangeStatus(ChangeStatusRequest request)
        {
            var item = await _manageSpecies.getItemById(request.Id);
            if (!HelperMethod.CheckUser(item.CreatedBy, User))
            {
                return Json(new { success = false, message = "Bạn không có quyền thay đổi" });
            }
            var result = await _manageSpecies.ChangeStatus(request);
            if (result > 0)
            {
                return Json(new { success = true, message = "Thuộc tính đã được thay đổi." });
            }
            return Json(new { success = true, message = "Thuộc tính không được thay đổi." });
        }
        [HttpGet]
        public async Task<IActionResult> Details(int Id)
        {
            var result = await _manageSpecies.getItemById(Id);
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
        [HttpGet]
        public async Task<IActionResult> AutoCompleteInfoSpecies(int Id)
        {
            if (Id == 0)
                return null;
            var result = await _manageSpeciesGeneral.getItemById(Id);
            if (result == null)
                return null;
            var ho = await _manageFamily.getItemById(result.IdDtvHo ?? 0);
            var bo = await _manageSet.getItemById(ho.IdDtvBo ?? 0);
            var lop = await _manageClass.getItemById(bo.IdDtvLop ?? 0);
            var nganh = await _manageBranch.getItemById(lop.IdDtvNganh ?? 0);
            return Json(new
            {
                NameHo = ho.Name,
                NameBo = bo.Name,
                NameLop = lop.Name,
                NameNganh = nganh.Name
            });
        }

    }
}
