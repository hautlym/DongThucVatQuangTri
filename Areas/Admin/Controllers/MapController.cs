using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.Tours.Dtos;
using DongThucVatQuangTri.Applications.Tours;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using DongThucVatQuangTri.Applications.Maps;
using DongThucVatQuangTri.Applications.Maps.Dtos;

namespace DongThucVatQuangTri.Areas.Admin.Controllers
{
    [Area("admin")]
    [Authorize(Policy = "AdministatorOrNationParkPolicy")]
    public class MapController : Controller
    {
        private readonly IManageMap _manageMap;
        public MapController(IManageMap manageMap)
        {
            _manageMap = manageMap;
        }
        public async Task<IActionResult> Index(string keyword, int PageIndex = 1, int PageSize = 10)
        {
            var request = new GetMapPagingRequest()
            {
                PageIndex = PageIndex,
                PageSize = PageSize,
                Keyword = keyword
            };
            var data = await _manageMap.GetAlllPaging(request);
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
        public async Task<IActionResult> Create([FromForm] CreateMapRequest request)
        {

            if (!ModelState.IsValid)
                return View();
            var result = await _manageMap.CreateMap(request);
            if (result > 0)
            {
                TempData["result"] = "Thêm thông tin thành công";
                return RedirectToAction("Index");
            }
            else
            {
                TempData["error"] = "bản đồ đã tồn tại";
                return RedirectToAction("Index");
            }
            return View(request);
        }

        [HttpGet]
        public async Task<IActionResult> Edit(int id)
        {
            var result = await _manageMap.getMapById(id);
            if (!HelperMethod.CheckUser(result.CreateBy, User))
            {
                TempData["error"] = "Bạn không được quyền chỉnh sửa";
                return RedirectToAction("Index");
            }
            if (result != null)
            {
                var updateRequest = new UpdateMapRequest()
                {
                    Id = result.Id,
                    Name = result.Name,
                    Url = result.linkMap,
                    Description = result.Description,
                    
                };
                return View(updateRequest);
            }
            return RedirectToAction("Error", "Home");
        }
        [HttpPost]
        [Consumes("multipart/form-data")]
        public async Task<IActionResult> Edit([FromForm] UpdateMapRequest request)
        {
            if (!ModelState.IsValid)
            {
                return View(request);
            }
            var result = await _manageMap.updateMap(request);
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
            var item = await _manageMap.getMapById(Id);
            if (!HelperMethod.CheckUser(item.CreateBy, User))
            {
                TempData["error"] = "Bạn không được quyền xóa";
                return RedirectToAction("Index");
            }
            var result = await _manageMap.deleteMap(Id);
            if (result > 0)
            {
                TempData["result"] = "Xóa thành công";
                return RedirectToAction("Index");

            }
            TempData["error"] = "Xóa không thành công";
            return RedirectToAction("Index");
        }
        [HttpGet]
        public async Task<IActionResult> Details(int Id)
        {
            var result = await _manageMap.getMapById(Id);
            return View(result);
        }
    }
}
