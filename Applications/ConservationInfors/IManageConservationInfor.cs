using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.ConservationInfors.Dtos;
using DongThucVatQuangTri.Applications.UserManage.Dtos;

namespace DongThucVatQuangTri.Applications.ConservationInfors
{
    public interface IManageConservationInfor
    {
        public Task<List<ConservationInforViewModel>> getAll();
        public Task<ConservationInforViewModel> getTourById(long id);
        Task<long> CreateTour(CreateConservationInforRequest request);
        public Task<ApiResult<PageResult<ConservationInforViewModel>>> GetAlllPaging(GetConservationInforPagingRequest request);
        Task<int> deleteTour(int id);
        public Task<ApiResult<PageResult<ConservationInforViewModel>>> PublicTourPaging(GetConservationInforPagingRequest request);
        public Task<int> updateConservationInfor(UpdateConservationInforRequest request);
        public Task<int> ChangeStatus(ChangeStatusRequest request);
        public Task<int> IncreaseView(int id);
    }
}
