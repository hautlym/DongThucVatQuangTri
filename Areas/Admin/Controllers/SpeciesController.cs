using DongThucVatQuangTri.Applications.AnimalsAndPlant.SetManage.Dtos;
using DongThucVatQuangTri.Applications.Banners.Dtos;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.FamilyManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage.Dtos;
using DongThucVatQuangTri.Applications.Enums;

namespace DongThucVatQuangTri.Areas.Admin.Controllers
{
    [Area("admin")]
    [Authorize(Policy = "AdministratorPolicy")]
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
                    GiaTriSuDung= result.GiaTriSuDung,
                    DacDiem= result.DacDiem,
                    PhanBo= result.PhanBo,
                    HinhAnh = result.FileDinhKem,
                    MucDoBaoTonIucn = result.MucDoBaoTonIucn,
                    MucDoBaoTonNd64cp = result.MucDoBaoTonNd64cp,
                    MucDoBaoTonNdcp = result.MucDoBaoTonNdcp,
                    MucDoBaoTonSdvn = result.MucDoBaoTonSdvn,
                    TenKhac = result.TenKhac,
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
            var result = await _manageSpecies.ChangeStatus(request);
            if (result > 0)
            {
                return Json(new { success = true, message = "Thuộc tính đã được thay đổi." });
            }
            return Json(new { success = true, message = "Thuộc tính không được thay đổi." });
        }
    }
}
