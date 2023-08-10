using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Banners.Dtos.BannerCategoryDtos;
using DongThucVatQuangTri.Applications.Banners.Dtos.BannerDtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using Microsoft.EntityFrameworkCore;

namespace DongThucVatQuangTri.Applications.Banners.ManageBanner
{
    public interface IManageBanner
    {
        public Task<BannerViewModels> getBannerById(long id);
        Task<long> CreateBanner(CreateBannerRequest request);
        public Task<ApiResult<PageResult<BannerViewModels>>> GetAlllPaging(GetBannerPagingRequest request);
        Task<int> deleteBanner(int id);
        public Task<int> updateBanner(UpdateBannerRequest request);
        public Task<int> ChangeStatus(ChangeStatusRequest request);
        public Task<int> ChangeSortOrder(ChangeSortOrderRequest request);
    }
}
