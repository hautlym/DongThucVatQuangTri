using DongThucVatQuangTri.Applications.Banners.Dtos.BannerDtos;
using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Banners.ManageBanner;
using DongThucVatQuangTri.Applications.Banners.ManageBannerCat;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using DongThucVatQuangTri.Applications.NewsItem.NewsManage;
using DongThucVatQuangTri.Applications.NewsItem.NewsCatManage;
using DongThucVatQuangTri.Applications.NewsItem.Dtos.NewsDtos;
using Microsoft.AspNetCore.Authorization;
using System.Net.Http.Headers;
using Microsoft.AspNetCore.Hosting;
using DongThucVatQuangTri.Models.Entities;
using System.Security.Claims;
using DongThucVatQuangTri.Applications.Common;

namespace DongThucVatQuangTri.Areas.Admin.Controllers
{
    [Area("admin")]
    [Authorize]
    public class NewsController : BaseController
    {
        private readonly IManageNews _news;
        private readonly IManageNewsCat _newsCat;
        private readonly IWebHostEnvironment _webHostEnvironment;
        public NewsController(IManageNews news, IManageNewsCat newsCat, IWebHostEnvironment webHostEnvironment)
        {
            _news = news;
            _newsCat = newsCat;
            _webHostEnvironment = webHostEnvironment;
        }
        public async Task<IActionResult> Index(string keyword, int PageIndex = 1, int PageSize = 10)
        {
            var request = new GetNewsPagingRequest()
            {
                PageIndex = PageIndex,
                PageSize = PageSize,
                Keyword = keyword
            };
            if(User.FindFirstValue(ClaimTypes.Role)!= "Administator")
            {
                request.typeNationPark = User.FindFirstValue(ClaimTypes.Role);
            }
            var data = await _news.GetAlllPaging(request);
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
        public async Task<IActionResult> Create([FromForm] CreateNewsRequest request)
        {
            var categories = await _newsCat.GetAll();
            ViewBag.Categories = categories.Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Id.ToString(),
            });
            if (!ModelState.IsValid)
                return View();

            request.Author = User.FindFirstValue(ClaimTypes.NameIdentifier);
            var result = await _news.CreateNews(request);
            if (result > 0)
            {
                TempData["result"] = "Thêm tin tức thành công";
                return RedirectToAction("Index");

            }
            ModelState.AddModelError("Name", "Tin đã tồn tại");
            ModelState.AddModelError("Alias", "alias đã tồn tại");
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
            var result = await _news.getNewsById(id);
            if (!HelperMethod.CheckUser(result.Author, User))
            {
                TempData["error"] = "Bạn không được quyền chỉnh sửa";
                return RedirectToAction("Index");
            }
            if (result != null)
            {
                var updateRequest = new UpdateNewsRequest()
                {
                    Id = result.Id,
                    Alias = result.Alias,
                    NewsCatId = result.NewsCatId,
                    Name = result.Name,
                    linkUrl = result.Image,
                    ShortDescription = result.ShortDescription,
                    Description = result.Description,
                    SortOrder = result.SortOrder,
                    IsHot = result.IsHot,
                    Status = result.Status,
                    Author = result.Author,
                    TitleSeo = result.TitleSeo,
                    ContentSeo = result.ContentSeo,
                    KeySeo = result.KeySeo,
                    typeNationPark = result.typeNationPark

                };
                return View(updateRequest);
            }
            return RedirectToAction("Error", "Home");
        }
        [HttpPost]
        [Consumes("multipart/form-data")]
        public async Task<IActionResult> Edit([FromForm] UpdateNewsRequest request)
        {
            var categories = await _newsCat.GetAll();
            ViewBag.Categories = categories.Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Id.ToString(),
            });
            if (!ModelState.IsValid)
                return View();

            var result = await _news.updateNews(request);
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
            var item = await _news.getNewsById(Id);
            if (!HelperMethod.CheckUser(item.Author, User))
            {
                TempData["error"] = "Bạn không được quyền xóa";
                return RedirectToAction("Index");
            }
            var result = await _news.deleteNews(Id);
            if (result > 0)
            {
                TempData["result"] = "Xóa thành công";
                return RedirectToAction("Index");

            }
            TempData["error"] = "Xóa không thành công";
            return RedirectToAction("Index");
        }
        [HttpPost]
        public async Task<IActionResult> ChangeStatus(ChangeStatusRequest request)
        {
            var result = await _news.ChangeStatus(request);
            if (result > 0)
            {
                return Json(new { success = true, message = "Thuộc tính đã được thay đổi." });
            }
            return Json(new { success = true, message = "Thuộc tính không được thay đổi." });
        }
        [HttpPost]
        public async Task<IActionResult> ChangeIsHot(ChangeIsHotRequest request)
        {
            var result = await _news.ChangeIsHot(request);
            if (result > 0)
            {
                return Json(new { success = true, message = "Thuộc tính đã được thay đổi." });
            }
            return Json(new { success = true, message = "Thuộc tính không được thay đổi." });
        }
        [HttpPost]
        public async Task<IActionResult> IncreaseView(int id)
        {
            var result = await _news.IncreaseView(id);
            if (result > 0)
            {
                return Json(new { success = true, message = "Thuộc tính đã được thay đổi." });
            }
            return Json(new { success = true, message = "Thuộc tính không được thay đổi." });
        }
        //[Route("upload_CkEditor")]
        [HttpPost]
        public IActionResult UploadImage(IFormFile upload)
        {
            var originalFileName = ContentDispositionHeaderValue.Parse(upload.ContentDisposition).FileName.Trim('"');
            var fileName = $"{Guid.NewGuid()}{Path.GetExtension(originalFileName)}";
            var path = Path.Combine(Directory.GetCurrentDirectory(), _webHostEnvironment.WebRootPath, "newsImage", fileName);
            var stream = new FileStream(path, FileMode.Create);
            upload.CopyTo(stream);
            return new JsonResult(new { uploaded = 1, fileName = fileName, url = "/newsImage/" + fileName });
        }

        [HttpGet]
        public IActionResult FileBrowswe(IFormFile upload)
        {
            var dir = new DirectoryInfo(Path.Combine(_webHostEnvironment.WebRootPath, "newsImage"));
            ViewBag.FileInfos = dir.GetFiles();
            return View("fileBrowswe");
        }
        [HttpGet]
        public async Task<IActionResult> Details(int Id)
        {
            var result = await _news.getNewsById(Id);
            return View(result);
        }
    }
}
