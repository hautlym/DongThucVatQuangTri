using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Banners.Dtos.BannerCategoryDtos;
using DongThucVatQuangTri.Applications.Banners.ManageBannerCat;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace DongThucVatQuangTri.Areas.Admin.Controllers
{
    [Area("admin")]
    [Authorize(Roles = "Admin")]
    public class BannerCatController : BaseController
    {
        private readonly IManageBannerCat _bannerCat;
        public BannerCatController(IManageBannerCat bannerCat)
        {
            _bannerCat = bannerCat;
        }
        public async Task<IActionResult> Index(string keyword, int PageIndex = 1, int PageSize = 10)
        {
            var request = new GetBannerCatPagingRequest()
            {
                PageIndex = PageIndex,
                PageSize = PageSize,
                Keyword = keyword
            };
            var data = await _bannerCat.GetAlllPaging(request);
            ViewBag.Keyword = keyword;
            if (TempData["result"] != null)
            {
                ViewBag.SuscessMsg = TempData["result"];
            }
            return View(data.ResultObj);
        }
        [HttpGet]
        public async Task<IActionResult> Create()
        {
            var categories = await _bannerCat.GetAll();
            ViewBag.Categories = categories.Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Id.ToString(),
            });
            return View();
        }
        [HttpPost]
        [Consumes("multipart/form-data")]
        public async Task<IActionResult> Create([FromForm] CreateBannerCatRequest request)
        {
            var categories = await _bannerCat.GetAll();
            ViewBag.Categories = categories.Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Id.ToString(),
            });
            if (!ModelState.IsValid)
                return View();


            var result = await _bannerCat.CreateBannerCat(request);
            if (result > 0)
            {
                TempData["result"] = "Thêm danh mục thành công";
                return RedirectToAction("Index");

            }
            return View(request);
        }

        [HttpGet]
        public async Task<IActionResult> Edit(int id)
        {
            var categories = await _bannerCat.GetAll();
            ViewBag.Categories = categories.Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Id.ToString(),
            });
            var result = await _bannerCat.getBannerCatById(id);
            if (result != null)
            {
                var updateRequest = new UpdateBannerCatRequest()
                {
                    Name = result.Name,
                    ParentId = result.ParentId,
                    Path = result.Path,
                    Level = result.Level,
                    linkImg = result.Image,
                    Status = result.Status,
                    Description = result.Description,
                    SortOrder = result.SortOrder,
                    Language = result.Language,
                    IdRelated = result.IdRelated,

                };
                return View(updateRequest);
            }
            return RedirectToAction("Error", "Home");
        }
        [HttpPost]
        [Consumes("multipart/form-data")]
        public async Task<IActionResult> Edit([FromForm] UpdateBannerCatRequest request)
        {
            var categories = await _bannerCat.GetAll();
            ViewBag.Categories = categories.Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Id.ToString(),
            });
            if (!ModelState.IsValid)
                return View();

            var result = await _bannerCat.updateBannerCar(request);
            if (result > 0)
            {
                TempData["result"] = "Cập nhật thông tin thành công";
                return RedirectToAction("Index");

            }

            ModelState.AddModelError("", "Cập nhật không thành công");
            return View(request);
        }
        [HttpPost]
        public async Task<IActionResult> Delete(int Id)
        {
            if (!ModelState.IsValid)
                return RedirectToAction("Index");

            var result = await _bannerCat.deleteBannerCat(Id);
            if (result > 0)
            {
                TempData["result"] = "Xóa danh mục thành công";
                return RedirectToAction("Index");

            }
            TempData["error"] = "Xóa danh mục không thành công";
            return RedirectToAction("Index");
        }
        [HttpPost]
        public async Task<IActionResult> ChangeStatus(ChangeStatusRequest request)
        {
            var result = await _bannerCat.ChangeStatus(request);
            if (result > 0)
            {
                return Json(new { success = true, message = "Thuộc tính đã được thay đổi." });
            }
            return Json(new { success = true, message = "Thuộc tính không được thay đổi." });
        }
    }
}
