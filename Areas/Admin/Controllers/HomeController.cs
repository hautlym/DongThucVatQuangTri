using DongThucVatQuangTri.Applications.Animals;
using Microsoft.AspNetCore.Mvc;
using System.Security.Cryptography;

namespace DongThucVatQuangTri.Areas.Admin.Controllers
{
    [Area("admin")]
    public class HomeController : Controller
    {
        private readonly ITestAnimal _data;
        public HomeController(ITestAnimal data)
        {
            _data = data;
        }
        public IActionResult Index()
        {
            
            var a = _data.getAnimal();
            ViewBag.NumberRecord = a;
            return View();
        }
    }
}
