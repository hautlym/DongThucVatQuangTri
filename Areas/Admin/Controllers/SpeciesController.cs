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
using DongThucVatQuangTri.Applications.Common;

namespace DongThucVatQuangTri.Areas.Admin.Controllers
{
    [Area("admin")]
    [Authorize(Policy = "AdministatorOrNationParkPolicy")]
    public class SpeciesController : BaseController
    {
        private readonly IManageFamily _manageFamily;
        private readonly IManageSpecies _manageSpecies;
        public SpeciesController(IManageFamily manageFamily, IManageSpecies manageSpecies)
        {
            _manageFamily = manageFamily;
            _manageSpecies = manageSpecies;
        }

        public async Task<IActionResult> Index(int loai, string keyword = "", int PageIndex = 1, int PageSize = 10)
        {
            var request = new GetSpeciesRequest()
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
            var ListItem = await _manageFamily.getAllItem();
            ViewBag.Categories = ListItem.Where(x => x.Loai == loai).Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Id.ToString(),
            });
            ViewBag.MucDoBaoTonIUCN = MucDoBaoTon.MuDoBaoTonIUCN.Select(x => new SelectListItem()
            {
                Text = x.Value,
                Value = x.Key.ToString(),
                
            });
            ViewBag.MucDoBaoTonSDVN = MucDoBaoTon.MuDoBaoTonSDVN.Select(x => new SelectListItem()
            {
                Text = x.Value,
                Value = x.Key.ToString(),
            });
            ViewBag.MucDoBaoTonNDCP= MucDoBaoTon.MuDoBaoTonNDCP[loai].Select(x => new SelectListItem()
            {
                Text = x.Value,
                Value = x.Key.ToString(),
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
        public async Task<IActionResult> Create(int loai,[FromForm] CreateSpeciesRequest request)
        {
            int LoaiDtv = loai;
            var ListItem = await _manageFamily.getAllItem();
            ViewBag.Categories = ListItem.Where(x => x.Loai == loai).Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Id.ToString(),
            });
            ViewBag.MucDoBaoTonIUCN = MucDoBaoTon.MuDoBaoTonIUCN.Select(x => new SelectListItem()
            {
                Text = x.Value,
                Value = x.Key.ToString(),

            });
            ViewBag.MucDoBaoTonSDVN = MucDoBaoTon.MuDoBaoTonSDVN.Select(x => new SelectListItem()
            {
                Text = x.Value,
                Value = x.Key.ToString(),
            });
            ViewBag.MucDoBaoTonNDCP = MucDoBaoTon.MuDoBaoTonNDCP[loai].Select(x => new SelectListItem()
            {
                Text = x.Value,
                Value = x.Key.ToString(),
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
            var result = await _manageSpecies.createItem(request);
            if (result == -2)
            {
                ViewBag.ErrorMsg = "loài đã tồn tại";
                return View();
            }
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
            var ListItem = await _manageFamily.getAllItem();
            ViewBag.Categories = ListItem.Where(x => x.Loai == result.Loai).Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Id.ToString(),
            });
            ViewBag.MucDoBaoTonIUCN = MucDoBaoTon.MuDoBaoTonIUCN.Select(x => new SelectListItem()
            {
                Text = x.Value,
                Value = x.Key.ToString(),

            });
            ViewBag.MucDoBaoTonSDVN = MucDoBaoTon.MuDoBaoTonSDVN.Select(x => new SelectListItem()
            {
                Text = x.Value,
                Value = x.Key.ToString(),
            });
            ViewBag.MucDoBaoTonNDCP = MucDoBaoTon.MuDoBaoTonNDCP[(int)result.Loai].Select(x => new SelectListItem()
            {
                Text = x.Value,
                Value = x.Key.ToString(),
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
                var updateRequest = new UpdateSpeciesRequest()
                {
                    Name = result.Name,
                    NameLatinh = result.NameLatinh,
                    Status = result.Status,
                    IdDtvHo = result.IdDtvHo,
                    MucDoBaoTonIucn = result.MucDoBaoTonIucn,
                    MucDoBaoTonNd64cp = result.MucDoBaoTonNd64cp,
                    MucDoBaoTonNdcp = result.MucDoBaoTonNdcp,
                    MucDoBaoTonSdvn = result.MucDoBaoTonSdvn,
                    Id = result.Id,
                };
                return View(updateRequest);
            }
            return RedirectToAction("Error", "Home");
        }
        [HttpPost]
        [Consumes("multipart/form-data")]
        public async Task<IActionResult> Edit(int loai,[FromForm] UpdateSpeciesRequest request)
        {
            int LoaiDtv = loai;
            var ListItem = await _manageFamily.getAllItem();
            ViewBag.Categories = ListItem.Where(x => x.Loai == loai).Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Id.ToString(),
            });
            ViewBag.MucDoBaoTonIUCN = MucDoBaoTon.MuDoBaoTonIUCN.Select(x => new SelectListItem()
            {
                Text = x.Value,
                Value = x.Key.ToString(),

            });
            ViewBag.MucDoBaoTonSDVN = MucDoBaoTon.MuDoBaoTonSDVN.Select(x => new SelectListItem()
            {
                Text = x.Value,
                Value = x.Key.ToString(),
            });
            ViewBag.MucDoBaoTonNDCP = MucDoBaoTon.MuDoBaoTonNDCP[loai].Select(x => new SelectListItem()
            {
                Text = x.Value,
                Value = x.Key.ToString(),
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
            if (result == -2)
            {
                ViewBag.ErrorMsg = "loài đã tồn tại";
                return View();

            }
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
            
            ViewBag.MucDoBaoTonIUCN = !String.IsNullOrEmpty(result.MucDoBaoTonIucn.ToString()) && result.MucDoBaoTonIucn!=0 ? MucDoBaoTon.MuDoBaoTonIUCN[(int)result.MucDoBaoTonIucn]:"";
            ViewBag.MucDoBaoTonSDVN = !String.IsNullOrEmpty(result.MucDoBaoTonSdvn.ToString()) && result.MucDoBaoTonSdvn != 0 ? MucDoBaoTon.MuDoBaoTonSDVN[(int)result.MucDoBaoTonSdvn] : "";
            ViewBag.MucDoBaoTonNDCP = !String.IsNullOrEmpty(result.MucDoBaoTonNdcp.ToString()) && result.MucDoBaoTonNdcp != 0 ? MucDoBaoTon.MuDoBaoTonNDCP[(int)loai][(int)result.MucDoBaoTonNdcp]:"";
            ViewBag.MucDoBaoTonND64CP = !String.IsNullOrEmpty(result.MucDoBaoTonNd64cp.ToString()) && result.MucDoBaoTonNd64cp != 0 ? MucDoBaoTon.MuDoBaoTonNDCP[ (int)loai][(int)result.MucDoBaoTonNd64cp]:"";
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
