using DongThucVatQuangTri.Applications.Common;
using Microsoft.AspNetCore.Mvc;

namespace DongThucVatQuangTri.Controllers.Components
{
    public class PagiViewComponent : ViewComponent
    {
        public Task<IViewComponentResult> InvokeAsync(PageResultBase result)
        {
            return Task.FromResult((IViewComponentResult)View("Default", result));
        }
    }
}
