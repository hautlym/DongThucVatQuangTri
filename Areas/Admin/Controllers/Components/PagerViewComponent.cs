using DongThucVatQuangTri.Applications.Common;
using Microsoft.AspNetCore.Mvc;

namespace DongThucVatQuangTri.Areas.Admin.Controllers.Components
{
    public class PagerViewComponent : ViewComponent
    {
        public Task<IViewComponentResult> InvokeAsync(PageResultBase result)
        {
            return Task.FromResult((IViewComponentResult)View("Default", result));
        }
    }
}
