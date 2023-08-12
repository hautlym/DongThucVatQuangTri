using DongThucVatQuangTri.Applications.AnimalsAndPlant.FamilyManage.Dtos;
using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.UserManage.Dtos;

namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.FamilyManage
{
    public interface IManageFamily
    {
        public Task<List<FamilyViewModels>> getAllItem();
        public Task<FamilyViewModels> getItemById(int id);
        public Task<ApiResult<PageResult<FamilyViewModels>>> GetAlllPaging(GetFamilyRequest request);
        public Task<int> updateItem(UpdateFamilyRequest request);
        public Task<long> createItem(CreateFamilyRequest request);
        public Task<int> deleteItem(int id);
        public Task<int> ChangeStatus(ChangeStatusRequest request);
    }
}
