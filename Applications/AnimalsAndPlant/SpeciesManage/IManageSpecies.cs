using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage.Dtos;
using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.UserManage.Dtos;

namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage
{
    public interface IManageSpecies
    {
        //public Task<List<SpeciesViewModels>> getAllItem();
        public Task<SpeciesViewModels> getItemById(int id);
        public Task<ApiResult<PageResult<SpeciesViewModels>>> GetAlllPaging(GetSpeciesRequest request);
        public Task<int> updateItem(UpdateSpeciesRequest request);
        public Task<long> createItem(CreateSpeciesRequest request);
        public Task<int> deleteItem(int id);
        public Task<int> ChangeStatus(ChangeStatusRequest request);
    }
}
