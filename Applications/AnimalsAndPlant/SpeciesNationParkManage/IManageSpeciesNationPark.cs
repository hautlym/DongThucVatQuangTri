using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage.Dtos;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesNationParkManage.Dtos;
using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using DongThucVatQuangTri.Areas.Admin.Models;

namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesNationParkManage
{
    public interface IManageSpeciesNationPark
    {
        public Task<List<SpeciesNationParkViewModel>> getAllItem();
        public Task<SpeciesNationParkViewModel> getItemById(int id);
        public Task<ApiResult<PageResult<SpeciesNationParkViewModel>>> GetAlllPaging(getSpeciesNationParkRequest request);
        public Task<int> updateItem(UpdateSpeciesNationParkRequest request);
        public Task<long> createItem(CreateSpeciesNationParkRequest request);
        public Task<int> deleteItem(int id);
        public Task<int> ChangeStatus(ChangeStatusRequest request);
        public Task<List<ImageModel>> getImage();
    }
}
