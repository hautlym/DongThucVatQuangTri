using DongThucVatQuangTri.Applications.AnimalsAndPlant.ClassManage.Dtos;
using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.UserManage.Dtos;

namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.ClassManage
{
    public interface IManageClass
    {
        public Task<List<ClassViewModels>> getAllItem();
        public Task<ClassViewModels> getItemById(int id);
        public Task<ApiResult<PageResult<ClassViewModels>>> GetAlllPaging(GetClassRequest request);
        public Task<int> updateItem(UpdateClassRequest request);
        public Task<long> createItem(CreateClassRequest request);
        public Task<int> deleteItem(int id);
        public Task<int> ChangeStatus(ChangeStatusRequest request);
    }
}
