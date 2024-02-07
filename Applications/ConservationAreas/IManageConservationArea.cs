using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.ConservationAreas.Dtos;
using DongThucVatQuangTri.Applications.UserManage.Dtos;

namespace DongThucVatQuangTri.Applications.ConservationAreas
{
    public interface IManageConservationArea
    {
        public Task<List<ConservationAreaViewModel>> getAll();
        public Task<ConservationAreaViewModel> getById(long id);
        Task<long> Create(CreateConservationAreaRequest request);
        public Task<ApiResult<PageResult<ConservationAreaViewModel>>> GetAlllPaging(getConservationPagingRequest request);
        Task<int> delete(int id);
        public Task<int> update(UpdateConservationAreaRequest request);
    }
}
