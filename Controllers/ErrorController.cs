using Microsoft.AspNetCore.Diagnostics;
using Microsoft.AspNetCore.Mvc;

namespace BanThietBiDiDongDATN.Admin.Controllers
{
    public class ErrorController : Controller
    {
        [Route("Error/General")]
        public IActionResult General()
        {
            return View("Error");
        }

        [Route("Error/{statusCode}")]
        public IActionResult HandleErrorCode(int statusCode)
        {
            switch (statusCode)
            {
                case 404:
                    return View("NotFound");
                case 500:
                    return View("ServerError");
                default:
                    return View("Error");
            }
        }
    }
}
