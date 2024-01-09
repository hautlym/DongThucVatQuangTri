using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.Tours.Dtos;
using DongThucVatQuangTri.Applications.UserManage.Dtos;

namespace DongThucVatQuangTri.Applications.Tours
{
    public interface IManageTour
    {
        public Task<List<TourViewModel>> getAll();
        public Task<TourViewModel> getTourById(long id);
        Task<long> CreateTour(CreateTourRequest request);
        public Task<ApiResult<PageResult<TourViewModel>>> GetAlllPaging(GetTourPagingRequest request);
        Task<int> deleteTour(int id);
        public Task<ApiResult<PageResult<TourViewModel>>> PublicTourPaging(GetTourPagingRequest request);
        public Task<int> updateTour(UpdateTourRequest request);
        public Task<int> ChangeStatus(ChangeStatusRequest request);
        public Task<int> IncreaseView(int id);
    }
}
