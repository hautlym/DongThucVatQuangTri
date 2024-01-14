using DongThucVatQuangTri.Applications.Common;

namespace DongThucVatQuangTri.Applications.Roles.Dtos
{
    public class getRolePaging:PagingRequestBase
    {
        public string? Keyword { get; set; }
    }
}
