using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.Tours.TourCat;
using DongThucVatQuangTri.Applications.UserManage.Dtos;

namespace DongThucVatQuangTri.Applications.Tours
{
    public interface IManageTourCat
    {
        Task<List<TourCatViewModel>> GetAll();
        public Task<TourCatViewModel> getTourCatById(int id);
        Task<long> CreateTourCat(CreateTourCatRequest request);
        public Task<ApiResult<PageResult<TourCatViewModel>>> GetAlllPaging(getTourCatPagingRequest request);
        Task<int> deleteTourCat(int id);
        public Task<int> updateTourCat(UpdateTourCatRequest request);
        public Task<int> ChangeStatus(ChangeStatusRequest request);
    }
}
