using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.Maps.Dtos;
using DongThucVatQuangTri.Applications.UserManage.Dtos;

namespace DongThucVatQuangTri.Applications.Maps
{
    public interface IManageMap
    {
        public Task<List<MapViewModel>> getAll();
        public Task<MapViewModel> getMapById(long id);
        Task<long> CreateMap(CreateMapRequest request);
        public Task<ApiResult<PageResult<MapViewModel>>> GetAlllPaging(GetMapPagingRequest request);
        Task<int> deleteMap(int id);
        public Task<int> updateMap(UpdateMapRequest request);
    }
}
