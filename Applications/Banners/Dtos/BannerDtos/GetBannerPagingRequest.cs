using DongThucVatQuangTri.Applications.Common;

namespace DongThucVatQuangTri.Applications.Banners.Dtos.BannerDtos
{
    public class GetBannerPagingRequest: PagingRequestBase
    {
        public string? Keyword { get; set; }
        public int? status { get; set; }
    }
}
