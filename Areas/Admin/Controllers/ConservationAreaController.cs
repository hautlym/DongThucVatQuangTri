using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.Tours.Dtos;
using DongThucVatQuangTri.Applications.Tours;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using DongThucVatQuangTri.Applications.ConservationAreas;
using DongThucVatQuangTri.Applications.ConservationAreas.Dtos;

namespace DongThucVatQuangTri.Areas.Admin.Controllers
{
    [Area("admin")]
    [Authorize(Policy = "AdministratorPolicy")]
    public class ConservationAreaController : BaseController
    {
        private readonly IManageConservationArea _manageConservationArea;
        private readonly IWebHostEnvironment _webHostEnvironment;
        public ConservationAreaController(IManageConservationArea manageConservationArea, IWebHostEnvironment webHostEnvironment)
        {
            _manageConservationArea = manageConservationArea;
            _webHostEnvironment = webHostEnvironment;
        }
        [AllowAnonymous]
        public async Task<IActionResult> Index(string keyword, int PageIndex = 1, int PageSize = 10)
        {
            var request = new getConservationPagingRequest()
            {
                PageIndex = PageIndex,
                PageSize = PageSize,
                Keyword = keyword
            };
            
            var data = await _manageConservationArea.GetAlllPaging(request);
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
        public async Task<IActionResult> Create([FromForm] CreateConservationAreaRequest request)
        {

            if (!ModelState.IsValid)
                return View();
            var result = await _manageConservationArea.Create(request);
            if (result > 0)
            {
                TempData["result"] = "Thêm thông tin thành công";
                return RedirectToAction("Index");
            }
            if(result==-1)
            {
                TempData["error"] = "Khu bảo tồn đã tồn tại";
                return RedirectToAction("Index");
            }
            return View(request);
        }

        [HttpGet]
        public async Task<IActionResult> Edit(int id)
        {
            var result = await _manageConservationArea.getById(id);
           
            if (result != null)
            {
                var updateRequest = new UpdateConservationAreaRequest()
                {
                    Id = result.Id,
                    linkUrl = result.Image,
                    Description = result.Description,
                    NameConservation= result.NameConservation,
                    Address= result.Address,
                    Phone= result.Phone,
                    Email= result.Email,
                };
                return View(updateRequest);
            }
            return RedirectToAction("Error", "Home");
        }
        [HttpPost]
        [Consumes("multipart/form-data")]
        public async Task<IActionResult> Edit([FromForm] UpdateConservationAreaRequest request)
        {
            if (!ModelState.IsValid)
            {
                return View(request);
            }
            var result = await _manageConservationArea.update(request);
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
            var result = await _manageConservationArea.delete(Id);
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
            var result = await _manageConservationArea.getById(Id);
            return View(result);
        }
    }
}
