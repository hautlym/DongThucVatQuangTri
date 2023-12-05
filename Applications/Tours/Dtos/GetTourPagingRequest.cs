using DongThucVatQuangTri.Applications.Common;

namespace DongThucVatQuangTri.Applications.Tours.Dtos
{
    public class GetTourPagingRequest : PageResultBase
    {
        public string? Keyword { get; set; }
        public int? status { get; set; }
    }
}
