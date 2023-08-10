using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Banners.Dtos.BannerDtos;
using DongThucVatQuangTri.Applications.Banners.ManageBanner;
using DongThucVatQuangTri.Applications.Banners.ManageBannerCat;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace DongThucVatQuangTri.Areas.Admin.Controllers
{
    [Area("admin")]
    public class BannerController : BaseController
    {
        private readonly IManageBanner _banner;
        private readonly IManageBannerCat _bannerCat;
        public BannerController(IManageBanner banner, IManageBannerCat bannerCat)
        {
            _banner = banner;
            _bannerCat = bannerCat;
        }
        public async Task<IActionResult> Index(string keyword, int PageIndex = 1, int PageSize = 10)
        {
            var request = new GetBannerPagingRequest()
            {
                PageIndex = PageIndex,
                PageSize = PageSize,
                Keyword = keyword
            };
            var data = await _banner.GetAlllPaging(request);
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
        public async Task<IActionResult> Create([FromForm] CreateBannerRequest request)
        {
            var categories = await _bannerCat.GetAll();
            ViewBag.Categories = categories.Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Id.ToString(),
            });
            if (!ModelState.IsValid)
                return View();


            var result = await _banner.CreateBanner(request);
            if (result > 0)
            {
                TempData["result"] = "Thêm banner thành công";
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
            var result = await _banner.getBannerById(id);
            if (result != null)
            {
                var updateRequest = new UpdateBannerRequest()
                {
                    Name = result.Name,
                    Link= result.Link,
                    linkUrl =  result.Src,
                    linkUrlMobile = result.SrcMobile,
                    Status = result.Status,
                    Description = result.Description,
                    SortOrder = result.SortOrder,
                    Language = result.Language,
                    IdRelated = result.IdRelated,
                    BannerCatId = result.BannerCatId,
                };
                return View(updateRequest);
            }
            return RedirectToAction("Error", "Home");
        }
        [HttpPost]
        [Consumes("multipart/form-data")]
        public async Task<IActionResult> Edit([FromForm] UpdateBannerRequest request)
        {
            var categories = await _bannerCat.GetAll();
            ViewBag.Categories = categories.Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Id.ToString(),
            });
            if (!ModelState.IsValid)
                return View();

            var result = await _banner.updateBanner(request);
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

            var result = await _banner.deleteBanner(Id);
            if (result > 0)
            {
                TempData["result"] = "Xóa banner thành công";
                return RedirectToAction("Index");

            }
            TempData["error"] = "Xóa banner không thành công";
            return RedirectToAction("Index");
        }
        [HttpPost]
        public async Task<IActionResult> ChangeStatus(ChangeStatusRequest request)
        {
            var result = await _banner.ChangeStatus(request);
            if (result > 0)
            {
                return Json(new { success = true, message = "Thuộc tính đã được thay đổi." });
            }
            return Json(new { success = true, message = "Thuộc tính không được thay đổi." });
        }
        [HttpPost]
        public async Task<IActionResult> ChangeSortOrder(ChangeSortOrderRequest request)
        {
            var result = await _banner.ChangeSortOrder(request);
            if (result > 0)
            {
                return Json(new { success = true, message = "Thuộc tính đã được thay đổi." });
            }
            return Json(new { success = true, message = "Thuộc tính không được thay đổi." });
        }
    }
}
