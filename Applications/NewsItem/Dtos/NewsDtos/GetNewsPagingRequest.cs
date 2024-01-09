using DongThucVatQuangTri.Applications.Common;

namespace DongThucVatQuangTri.Applications.NewsItem.Dtos.NewsDtos
{
    public class GetNewsPagingRequest:PageResultBase
    {
        public int? type { get; set; }
        public string? Keyword { get; set; }
        public int? status { get; set; }
    }
}
