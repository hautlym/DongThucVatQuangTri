using DongThucVatQuangTri.Applications.Common;

namespace DongThucVatQuangTri.Applications.Tours.Dtos
{
    public class GetTourPagingRequest : PageResultBase
    {
        public int? type { get; set; }
        public string? Keyword { get; set; }
        public int? status { get; set; }
    }
}
