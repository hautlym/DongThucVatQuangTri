using DongThucVatQuangTri.Applications.AnimalsAndPlant.BranchManage.Dtos;
using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Banners.Dtos.BannerCategoryDtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.UserManage.Dtos;

namespace DongThucVatQuangTri.Applications.Banners.ManageBannerCat
{
    public interface IManageBannerCat
    {
        Task<List<BannerCatViewModels>> GetAll();
        public Task<BannerCatViewModels> getBannerCatById(int id);
        Task<long> CreateBannerCat(CreateBannerCatRequest request);
        public Task<ApiResult<PageResult<BannerCatViewModels>>> GetAlllPaging(GetBannerCatPagingRequest request);
        Task<int> deleteBannerCat(int id);
        public Task<int> updateBannerCar(UpdateBannerCatRequest request);
        public Task<int> ChangeStatus(ChangeStatusRequest request);
    }
}
