using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Models;
using Microsoft.AspNetCore.Mvc;

namespace DongThucVatQuangTri.Controllers.Components
{
    public class SearchNaturalViewComponent:ViewComponent
    {
        public Task<IViewComponentResult> InvokeAsync(SearchModel model)
        {
            return Task.FromResult((IViewComponentResult)View("SearchForm", model));
        }
    }
}
