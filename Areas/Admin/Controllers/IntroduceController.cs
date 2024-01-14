using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.Introduces;
using DongThucVatQuangTri.Applications.Introduces.Dtos;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace DongThucVatQuangTri.Areas.Admin.Controllers
{
    [Area("admin")]
    [Authorize]
    public class IntroduceController : Controller
    {
        private readonly IManageIntroduce _manageIntroduce;

        public IntroduceController(IManageIntroduce manageIntroduce)
        {
            _manageIntroduce = manageIntroduce;
        }
        public async Task<IActionResult> Index()
        {
            var data =await _manageIntroduce.getAll();
            if (TempData["result"] != null)
            {
                ViewBag.SuscessMsg = TempData["result"];
            }
            if (TempData["error"] != null)
            {
                ViewBag.ErrorMsg = TempData["error"];
            }
            return View(data);
        }
        [HttpGet]
        public async Task<IActionResult> Edit(int id)
        {
            var result =await _manageIntroduce.getById(id);
            if (result == null)
            {
                TempData["error"] = "Không tìm thấy bài viết";
                return RedirectToAction("Index");
            }
            if (result.typeNationPak != User.FindFirstValue(ClaimTypes.Role) && User.FindFirstValue(ClaimTypes.Role)!= "Administator")
            {
                TempData["error"] = "Bạn không được quyền chỉnh sửa";
                return RedirectToAction("Index");
            }
            
            var intro = new UpdateIntroduceRequest()
            {
                id = id,
                content = result.content,
                UpdateBy = result.UpdateBy,
            };
            return View(intro);
        }
        [HttpPost]
        public async Task<IActionResult> Edit(UpdateIntroduceRequest request)
        {
            if(!ModelState.IsValid)
            {
                return View(request);
            }
            var result =await _manageIntroduce.Update(request);
            if (result < 0)
            {
                if (result == -2)
                {
                    ModelState.AddModelError("title", "tiêu đề đã tồn tại");
                    return View();
                }
                TempData["error"] = "Sửa thông tin không thành công";
                return RedirectToAction("Index");
            }
            else
            {
                TempData["result"] = "Sửa thành công";
                return RedirectToAction("Index");
            }
        }
    }
}
