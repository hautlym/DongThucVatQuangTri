using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.ConservationInfors.Dtos;
using DongThucVatQuangTri.Applications.EcotourismSafeties.Dtos;
using DongThucVatQuangTri.Applications.UserManage.Dtos;

namespace DongThucVatQuangTri.Applications.EcotourismSafeties
{
    public interface IManageEcotourismSafety
    {
        public Task<List<EcotourismSafetyViewModel>> getAll();
        public Task<EcotourismSafetyViewModel> getById(long id);
        Task<long> Create(CreateEcotourismSafetyRequest request);
        public Task<ApiResult<PageResult<EcotourismSafetyViewModel>>> GetAlllPaging(GetEcotourismSafetyPagingRequest request);
        Task<int> delete(int id);
        public Task<ApiResult<PageResult<EcotourismSafetyViewModel>>> PublicPaging(GetEcotourismSafetyPagingRequest request);
        public Task<int> update(UpdateEcotourismSafetyRequest request);
        public Task<int> ChangeStatus(ChangeStatusRequest request);
        public Task<int> IncreaseView(int id);
    }
}
