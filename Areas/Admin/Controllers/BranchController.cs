using DongThucVatQuangTri.Applications.NewsItem.Dtos.NewsCatDtos;
using DongThucVatQuangTri.Models.Entities;
using Microsoft.AspNetCore.Mvc;
using static Microsoft.Extensions.Logging.EventSource.LoggingEventSource;
using System.Drawing.Printing;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.BranchManage.Dtos;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.BranchManage;
using Microsoft.AspNetCore.Authorization;

namespace DongThucVatQuangTri.Areas.Admin.Controllers
{
    [Area("admin")]
    [Authorize(Policy = "AdministratorPolicy")]
    public class BranchController : BaseController
    {
        private readonly IManageBranch _manageBranch;
        public BranchController(IManageBranch manageBranch)
        {
            _manageBranch = manageBranch;
        }
        public async Task<IActionResult> Index(int loai,string keyword="", int PageIndex = 1, int PageSize = 10)
        {
            var request = new GetBranchRequest()
            {
                PageIndex = PageIndex,
                PageSize = PageSize,
                keyword = keyword,
                loai = loai
            };
            if (loai == 1)
            {
                ViewBag.Loai = "Động vật";
            }
            if (loai == 0)
            {
                ViewBag.Loai = "Thực vật";
            }
             
            var data = await _manageBranch.GetAlllPaging(request);
            ViewBag.Keyword = keyword;
            if (TempData["result"] != null)
            {
                ViewBag.SuscessMsg = TempData["result"];
            }
            return View(data.ResultObj);
        }
    }
}
