using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.EcotourismSafeties;
using DongThucVatQuangTri.Applications.EcotourismSafeties.Dtos;
using DongThucVatQuangTri.Applications.Tours;
using DongThucVatQuangTri.Applications.Tours.Dtos;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.Net.Http.Headers;
using System.Security.Claims;

namespace DongThucVatQuangTri.Areas.Admin.Controllers
{
    [Area("admin")]
    [Authorize(Policy = "AdministatorOrNationParkPolicy")]
    public class EcotourismSafetyController : BaseController
    {
        private readonly IManageEcotourismSafety _manageEcotourismSafety;
        private readonly IWebHostEnvironment _webHostEnvironment;
        public EcotourismSafetyController(IManageEcotourismSafety manageEcotourismSafety, IWebHostEnvironment webHostEnvironment)
        {
            _webHostEnvironment = webHostEnvironment;
            _manageEcotourismSafety = manageEcotourismSafety;
        }
        [AllowAnonymous]
        public async Task<IActionResult> Index(string keyword, int PageIndex = 1, int PageSize = 10)
        {
            var request = new GetEcotourismSafetyPagingRequest()
            {
                PageIndex = PageIndex,
                PageSize = PageSize,
                Keyword = keyword
            };
            if (User.FindFirstValue(ClaimTypes.Role) != "Administator")
            {
                request.typeNationPark = User.FindFirstValue(ClaimTypes.Role);
            }
            var data = await _manageEcotourismSafety.GetAlllPaging(request);
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
            return View();
        }
        [HttpPost]
        [Consumes("multipart/form-data")]
        public async Task<IActionResult> Create([FromForm] CreateEcotourismSafetyRequest request)
        {
           
            if (!ModelState.IsValid)
                return View();
            var result = await _manageEcotourismSafety.Create(request);
            if (result > 0)
            {
                TempData["result"] = "Thêm thông tin thành công";
                return RedirectToAction("Index");

            }
            return View(request);
        }

        [HttpGet]
        public async Task<IActionResult> Edit(int id)
        {
            var result = await _manageEcotourismSafety.getById(id);
            if (!HelperMethod.CheckUser(result.Author, User))
            {
                TempData["error"] = "Bạn không được quyền chỉnh sửa";
                return RedirectToAction("Index");
            }
            if (result != null)
            {
                var updateRequest = new UpdateEcotourismSafetyRequest()
                {
                    Id = result.Id,
                    Alias = result.Alias,
                    Name = result.Name,
                    linkUrl = result.Image,
                    ShortDescription = result.ShortDescription,
                    Description = result.Description,
                    SortOrder = result.SortOrder,
                    Status = result.Status,
                    typeNationPark = result.typeNationPark,
                };
                return View(updateRequest);
            }
            return RedirectToAction("Error", "Home");
        }
        [HttpPost]
        [Consumes("multipart/form-data")]
        public async Task<IActionResult> Edit([FromForm] UpdateEcotourismSafetyRequest request)
        {
            if (!ModelState.IsValid)
            {
                return View(request);
            }
            var result = await _manageEcotourismSafety.update(request);
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
            var item = await _manageEcotourismSafety.getById(Id);
            if (!HelperMethod.CheckUser(item.Author, User))
            {
                TempData["error"] = "Bạn không được quyền xóa";
                return RedirectToAction("Index");
            }
            var result = await _manageEcotourismSafety.delete(Id);
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
            var result = await _manageEcotourismSafety.ChangeStatus(request);
            if (result > 0)
            {
                return Json(new { success = true, message = "Thuộc tính đã được thay đổi." });
            }
            return Json(new { success = true, message = "Thuộc tính không được thay đổi." });
        }
     
        [HttpPost]
        [AllowAnonymous]
        public async Task<IActionResult> IncreaseView(int id)
        {
            var result = await _manageEcotourismSafety.IncreaseView(id);
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
            var path = Path.Combine(Directory.GetCurrentDirectory(), _webHostEnvironment.WebRootPath, "EcotourismSafetyImage", fileName);
            var stream = new FileStream(path, FileMode.Create);
            upload.CopyTo(stream);
            return new JsonResult(new { uploaded = 1, fileName = fileName, url = "/EcotourismSafetyImage/" + fileName });
        }

        [HttpGet]
        public IActionResult FileBrowswe(IFormFile upload)
        {
            var dir = new DirectoryInfo(Path.Combine(_webHostEnvironment.WebRootPath, "EcotourismSafetyImage"));
            ViewBag.FileInfos = dir.GetFiles();
            return View("fileBrowswe");
        }
        [HttpGet]
        [AllowAnonymous]
        public async Task<IActionResult> Details(int Id)
        {
            var result = await _manageEcotourismSafety.getById(Id);
            return View(result);
        }
    }
}
