using DongThucVatQuangTri.Applications.AnimalsAndPlant.SetManage.Dtos;
using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.UserManage.Dtos;

namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.SetManage
{
    public interface IManageSet
    {
        public Task<List<SetViewModels>> getAllItem();
        public Task<SetViewModels> getItemById(int id);
        public Task<ApiResult<PageResult<SetViewModels>>> GetAlllPaging(GetSetRequest request);
        public Task<int> updateItem(UpdateSetRequest request);
        public Task<long> createItem(CreateSetRequest request);
        public Task<int> deleteItem(int id);
        public Task<int> ChangeStatus(ChangeStatusRequest request);
    }
}
