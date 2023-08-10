using DongThucVatQuangTri.Applications.Common;

namespace DongThucVatQuangTri.Applications.NewsItem.Dtos.NewsCatDtos
{
    public class GetNewsCatPagingRequest : PagingRequestBase
    {
        public string? Keyword { get; set; }
        public int? status { get; set; }
    }
}
