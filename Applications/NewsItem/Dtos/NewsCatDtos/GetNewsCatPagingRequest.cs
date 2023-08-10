using DongThucVatQuangTri.Applications.Common;

namespace DongThucVatQuangTri.Applications.News.Dtos.NewsCatDtos
{
    public class GetNewsCatPagingRequest: PagingRequestBase
    {
        public string? Keyword { get; set; }
        public int? status { get; set; }
    }
}
