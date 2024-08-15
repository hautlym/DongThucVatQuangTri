using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.Tours.Dtos;
using DongThucVatQuangTri.Applications.Tours;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using DongThucVatQuangTri.Applications.Maps;
using DongThucVatQuangTri.Applications.Maps.Dtos;
using Microsoft.AspNetCore.Hosting;
using DongThucVatQuangTri.Applications.Enums;

namespace DongThucVatQuangTri.Areas.Admin.Controllers
{
    [Area("admin")]
    [Authorize(Policy = "AdministatorOrNationParkPolicy")]
    public class MapController : Controller
    {
        private readonly IManageMap _manageMap;
        private readonly IWebHostEnvironment _webHostEnvironment;
        public MapController(IManageMap manageMap, IWebHostEnvironment webHostEnvironment)
        {
            _manageMap = manageMap;
            _webHostEnvironment = webHostEnvironment;
        }
        public async Task<IActionResult> Index(typeMap type,string keyword, int PageIndex = 1, int PageSize = 10)
        {
            var request = new GetMapPagingRequest()
            {
                PageIndex = PageIndex,
                PageSize = PageSize,
                Keyword = keyword,
                typeMap = (int)type
            };
            var data = await _manageMap.GetAlllPaging(request);
            ViewBag.Keyword = keyword;
            ViewBag.typeMap = type;
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
        public async Task<IActionResult> Create(typeMap? typeMap)
        {
            ViewBag.typeMap = typeMap;
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> Create([FromForm] CreateMapRequest request)
        {
            ViewBag.typeMap = request.typeMap;
            if (!ModelState.IsValid)
                return View();
            var result = await _manageMap.CreateMap(request);
            if (result > 0)
            {
                TempData["result"] = "Thêm thông tin thành công";
                return RedirectToAction("Index" , new { type = request.typeMap});
            }
            else if(result == -1)
            {
                ModelState.AddModelError("Name", "Tên bản đồ đã tồn tại");
            }
            else
            {
                TempData["error"] = "Thêm không thành công";
                return RedirectToAction("Index", new { type = request.typeMap });
            }
            return View(request);
        }

        [HttpGet]
        public async Task<IActionResult> Edit(int id)
        {
            var result = await _manageMap.getMapById(id);
            ViewBag.typeMap = result.typeMap;
            if (!HelperMethod.CheckUser(result.CreateBy, User))
            {
                TempData["error"] = "Bạn không được quyền chỉnh sửa";
                return RedirectToAction("Index", new { type = result.typeMap });
            }
            if (result != null)
            {
                var updateRequest = new UpdateMapRequest()
                {
                    Id = result.Id,
                    Name = result.Name,
                    Url = result.linkMap,
                    Description = result.Description,
                    typeMap = result.typeMap.ToString()
                };
                return View(updateRequest);
            }
            return RedirectToAction("Error", "Home");
        }
        [HttpPost]
        [Consumes("multipart/form-data")]
        public async Task<IActionResult> Edit([FromForm] UpdateMapRequest request)
        {
            ViewBag.typeMap = request.typeMap;
            if (!ModelState.IsValid)
            {
                return View(request);
            }
            var result = await _manageMap.updateMap(request);
            if (result > 0)
            {
                TempData["result"] = "Cập nhật thông tin thành công";
                return RedirectToAction("Index", new { type = request.typeMap });
            }

            ModelState.AddModelError("", "Cập nhật không thành công");
            return View(request);
        }
        [HttpPost]
        public async Task<IActionResult> Delete(int Id)
        {
            if (!ModelState.IsValid)
                return RedirectToAction("Index");
            var item = await _manageMap.getMapById(Id);
            if (!HelperMethod.CheckUser(item.CreateBy, User))
            {
                TempData["error"] = "Bạn không được quyền xóa";
                return RedirectToAction("Index", new { type = item.typeMap });
            }
            var result = await _manageMap.deleteMap(Id);
            if (result > 0)
            {
                TempData["result"] = "Xóa thành công";
                return RedirectToAction("Index", new { type = item.typeMap });

            }
            TempData["error"] = "Xóa không thành công";
            return RedirectToAction("Index", new { type = item.typeMap });
        }
        [HttpGet]
        public async Task<IActionResult> Details(int Id)
        {
            var result = await _manageMap.getMapById(Id);
            if (TempData["result"] != null)
            {
                ViewBag.SuscessMsg = TempData["result"];
            }
            if (TempData["error"] != null)
            {
                ViewBag.ErrorMsg = TempData["error"];
            }
            return View(result);
        }
        [HttpPost]
        public IActionResult DownloadRarFile(int Id, string fileName)
        {
            // Đường dẫn đến file .rar trên server
            var filePath = new DirectoryInfo(Path.Combine(_webHostEnvironment.WebRootPath, "maps", fileName));
            if(System.IO.File.Exists(filePath.FullName))
            {
                byte[] fileBytes = System.IO.File.ReadAllBytes(filePath.FullName);
                return File(fileBytes, "application/x-rar-compressed", fileName);
              
            }
            else
            {
                TempData["error"] = "file không tồn tại trên hệ thống";
                return RedirectToAction("Details", new { Id =Id}); ;
            }
            // Đọc dữ liệu từ file

            // Đặt tên file khi tải xuống
            // Trả về file như là phản hồi HTTP
            
        }
    }
}
