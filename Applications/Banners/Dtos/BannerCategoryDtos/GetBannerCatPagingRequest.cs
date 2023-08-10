using DongThucVatQuangTri.Applications.Common;

namespace DongThucVatQuangTri.Applications.Banners.Dtos.BannerCategoryDtos
{
    public class GetBannerCatPagingRequest: PagingRequestBase
    {
        public string? Keyword { get; set; }
        public int? status { get; set; }
    }
}
