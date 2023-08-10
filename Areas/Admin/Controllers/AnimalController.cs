using Microsoft.AspNetCore.Mvc;

namespace DongThucVatQuangTri.Areas.Admin.Controllers
{
    public class AnimalController : BaseController
    {

        public IActionResult Index()
        {
            return View();
        }
    }
}
