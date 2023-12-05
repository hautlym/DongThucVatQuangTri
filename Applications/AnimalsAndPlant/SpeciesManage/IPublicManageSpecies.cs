using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage.Dtos;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage.DtosPublic;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.UserManage.Dtos;

namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage
{
    public interface IPublicManageSpecies
    {
        public Task<List<SpeciesPublicViewModel>> getAllItem();
        public Task<DetailPublicSpeciesModel> getItemById(int id);
        public Task<ApiResult<PageResult<SpeciesPublicViewModel>>> GetAlllPaging(getSpeciesPublicRequest request);
        
    }
}
