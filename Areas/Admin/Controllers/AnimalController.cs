using Microsoft.AspNetCore.Mvc;

namespace DongThucVatQuangTri.Areas.Admin.Controllers
{
    public class AnimalController : Controller
    {

        public IActionResult Index()
        {
            return View();
        }
    }
}
