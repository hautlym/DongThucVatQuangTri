using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.Tours.Dtos;
using DongThucVatQuangTri.Applications.Tours;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using DongThucVatQuangTri.Applications.Contacts;
using DongThucVatQuangTri.Applications.Contacts.Dtos;
using DongThucVatQuangTri.Applications.Enums;

namespace DongThucVatQuangTri.Areas.Admin.Controllers
{
    [Area("admin")]
    [Authorize(Policy = "AdministatorOrNationParkPolicy")]
    public class ContactController : BaseController
    {
        private readonly IManageContact _manageContact;
        public ContactController(IManageContact manageContact)
        {
            _manageContact = manageContact;
        }
        public async Task<IActionResult> Index(string keyword, int PageIndex = 1, int PageSize = 10)
        {
            var request = new GetContactPaging()
            {
                PageIndex = PageIndex,
                PageSize = PageSize,
                Keyword = keyword
            };
            if (User.FindFirstValue(ClaimTypes.Role) != "Administator")
            {
                request.typeNationPark = User.FindFirstValue(ClaimTypes.Role);
            }
            var data = await _manageContact.GetAlllPaging(request);
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
        [AllowAnonymous]
        public async Task<IActionResult> Create([FromForm] CreateContactRequest request)
        {

            if (!ModelState.IsValid)
                return View();
            var result = await _manageContact.Create(request);
            if (result > 0)
            {
                TempData["result"] = "Thêm thông tin thành công";
                return RedirectToAction("Index");

            }
            return View(request);
        }

       
        [HttpPost]
        [Consumes("multipart/form-data")]
        public async Task<IActionResult> Edit([FromForm] UpdateContactRequest request)
        {
            if (!ModelState.IsValid)
            {
                return View(request);
            }
            var result = await _manageContact.updateContact(request);
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
            var item = await _manageContact.GetById(Id);
            if (!HelperMethod.CheckUser(item.typeNationPark, User))
            {
                TempData["error"] = "Bạn không được quyền xóa";
                return RedirectToAction("Index");
            }
            var result = await _manageContact.Delete(Id);
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
            var result = await _manageContact.ChangeStatus(request);
            if (result > 0)
            {
                return Json(new { success = true, message = "Thuộc tính đã được thay đổi." });
            }
            return Json(new { success = true, message = "Thuộc tính không được thay đổi." });
        }
        [HttpGet]
        public async Task<IActionResult> Details(int Id)
        {
            var result = await _manageContact.GetById(Id);
            return View(result);
        }
    }
}
