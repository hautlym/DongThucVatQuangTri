using DongThucVatQuangTri.Applications.Common;

namespace DongThucVatQuangTri.Applications.NewsItem.Dtos.NewsDtos
{
    public class GetNewsPagingRequest:PageResultBase
    {
        public string? Keyword { get; set; }
        public int? status { get; set; }
    }
}
