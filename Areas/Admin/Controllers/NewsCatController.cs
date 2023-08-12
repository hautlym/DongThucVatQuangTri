using DongThucVatQuangTri.Applications.Banners.Dtos.BannerCategoryDtos;
using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Banners.ManageBannerCat;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using DongThucVatQuangTri.Models.Entities;
using DongThucVatQuangTri.Applications.NewsItem.Dtos.NewsCatDtos;
using DongThucVatQuangTri.Applications.NewsItem.NewsCatManage;
using Microsoft.AspNetCore.Authorization;

namespace DongThucVatQuangTri.Areas.Admin.Controllers
{
    [Area("admin")]
    [Authorize(Policy = "AdminPolicy")]
    public class NewsCatController : BaseController
    {
        private readonly IManageNewsCat _newsCat;
        public NewsCatController(IManageNewsCat newsCat)
        {
            _newsCat = newsCat;
        }
        public async Task<IActionResult> Index(string keyword, int PageIndex = 1, int PageSize = 10)
        {
            var request = new GetNewsCatPagingRequest()
            {
                PageIndex = PageIndex,
                PageSize = PageSize,
                Keyword = keyword
            };
            var data = await _newsCat.GetAlllPaging(request);
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
            var categories = await _newsCat.GetAll();
            ViewBag.Categories = categories.Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Id.ToString(),
            });
            return View();
        }
        [HttpPost]
        [Consumes("multipart/form-data")]
        public async Task<IActionResult> Create([FromForm] CreateNewsCatRequest request)
        {
            var categories = await _newsCat.GetAll();
            ViewBag.Categories = categories.Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Id.ToString(),
            });
            if (!ModelState.IsValid)
                return View();


            var result = await _newsCat.CreateNewsCat(request);
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
            var categories = await _newsCat.GetAll();
            ViewBag.Categories = categories.Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Id.ToString(),
            });
            var newscat = await _newsCat.getNewsCatById(id);
            if (newscat != null)
            {
                var updateRequest = new UpdateNewsCatRequest()
                {
                    Id = newscat.Id,
                    Alias = newscat.Alias,
                    TitleSeo = newscat.TitleSeo,
                    ContentSeo = newscat.ContentSeo,
                    KeySeo = newscat.KeySeo,
                    Name = newscat.Name,
                    ParentId = newscat.ParentId,
                    linkUrl = newscat.Image,
                    Status = newscat.Status,
                    Description = newscat.Description,
                    SortOrder = newscat.SortOrder,
                    Language = newscat.Language,
                    IdRelated = newscat.IdRelated,
                };
                return View(updateRequest);
            }
            return RedirectToAction("Error", "Home");
        }
        [HttpPost]
        [Consumes("multipart/form-data")]
        public async Task<IActionResult> Edit([FromForm] UpdateNewsCatRequest request)
        {
            var categories = await  _newsCat.GetAll();
            ViewBag.Categories = categories.Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Id.ToString(),
            });
            if (!ModelState.IsValid)
                return View();

            var result = await _newsCat.updateNewsCat(request);
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

            var result = await _newsCat.deleteNewsCat(Id);
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
            var result = await _newsCat.ChangeStatus(request);
            if (result > 0)
            {
                return Json(new { success = true, message = "Thuộc tính đã được thay đổi." });
            }
            return Json(new { success = true, message = "Thuộc tính không được thay đổi." });
        }
    }
}
