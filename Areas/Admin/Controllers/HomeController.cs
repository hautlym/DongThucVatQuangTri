using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Cryptography;

namespace DongThucVatQuangTri.Areas.Admin.Controllers
{

    [Area("admin")]
    [Authorize]
    public class HomeController : BaseController
    {
        public HomeController()
        {
        }
        public IActionResult Index()
        {
            return View();
        }
    }
}
