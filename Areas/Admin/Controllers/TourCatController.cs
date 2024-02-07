using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.NewsItem.Dtos.NewsCatDtos;
using DongThucVatQuangTri.Applications.NewsItem.NewsCatManage;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.AspNetCore.Mvc;
using DongThucVatQuangTri.Applications.Tours;
using DongThucVatQuangTri.Models.Entities;
using System.Security.Claims;
using DongThucVatQuangTri.Applications.Tours.TourCat;
using Microsoft.AspNetCore.Authorization;

namespace DongThucVatQuangTri.Areas.Admin.Controllers
{
    [Area("admin")]
    [Authorize(Policy = "AdministatorOrNationParkPolicy")]
    public class TourCatController : BaseController
    {
        private readonly IManageTourCat _tourCat;
        public TourCatController(IManageTourCat tourCat)
        {
            _tourCat = tourCat;
        }
        public async Task<IActionResult> Index(string keyword, int PageIndex = 1, int PageSize = 10)
        {
            var request = new getTourCatPagingRequest()
            {
                PageIndex = PageIndex,
                PageSize = PageSize,
                Keyword = keyword,
                typeNationPark = User.FindFirstValue(ClaimTypes.Role)
            };
            var data = await _tourCat.GetAlllPaging(request);
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
            var categories = await _tourCat.GetAll();
            ViewBag.Categories = categories.Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Id.ToString(),
            });
            return View();
        }
        [HttpPost]
        [Consumes("multipart/form-data")]
        public async Task<IActionResult> Create([FromForm] CreateTourCatRequest request)
        {
            var categories = await _tourCat.GetAll();
            ViewBag.Categories = categories.Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Id.ToString(),
            });
            if (!ModelState.IsValid)
                return View();
            var result = await _tourCat.CreateTourCat(request);
            if (result > 0)
            {
                TempData["result"] = "Thêm danh mục thành công";
                return RedirectToAction("Index");
            }
            if(result ==-1)
            {
                TempData["error"] = "Danh mục đã tồn tại";
                return RedirectToAction("Index");
            }
            return View(request);
        }

        [HttpGet]
        public async Task<IActionResult> Edit(int id)
        {
            var categories = await _tourCat.GetAll();
            ViewBag.Categories = categories.Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Id.ToString(),
            });
            var newscat = await _tourCat.getTourCatById(id);
            if (newscat != null)
            {
                var updateRequest = new UpdateTourCatRequest()
                {
                    Id = newscat.Id,
                    Alias = newscat.Alias,
                    Name = newscat.Name,
                    linkUrl = newscat.Image,
                    Status = newscat.Status,
                    Description = newscat.Description,
                    SortOrder = newscat.SortOrder,
                    typeNationPark = newscat.typeNationPark
                };
                return View(updateRequest);
            }
            return RedirectToAction("Error", "Home");
        }
        [HttpPost]
        [Consumes("multipart/form-data")]
        public async Task<IActionResult> Edit([FromForm] UpdateTourCatRequest request)
        {
            var categories = await _tourCat.GetAll();
            ViewBag.Categories = categories.Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Id.ToString(),
            });
            if (!ModelState.IsValid)
                return View();

            var result = await _tourCat.updateTourCat(request);
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

            var result = await _tourCat.deleteTourCat(Id);
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
            var result = await _tourCat.ChangeStatus(request);
            if (result > 0)
            {
                return Json(new { success = true, message = "Thuộc tính đã được thay đổi." });
            }
            return Json(new { success = true, message = "Thuộc tính không được thay đổi." });
        }
        [HttpGet]
        public async Task<IActionResult> Details(int Id)
        {
            var result = await _tourCat.getTourCatById(Id);
            return View(result);
        }
    }
}

