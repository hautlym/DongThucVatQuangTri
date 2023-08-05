using DongThucVatQuangTri.Applications.AnimalsAndPlant.BranchManage.Dtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Models.Entities;

namespace DongThucVatQuangTri.Applications.Animals.BranchAnimalManage
{
    public interface IManageBranch
    {
        public Task<List<DtvNganh>> getAllItem();
        public Task<DtvNganh> getItemById(int id);
        public Task<PageResult<BranchViewModel>> GetAlllPaging(GetBranchRequest request);
        public Task<DtvNganh> getItemByName(string name);
        public Task<int> updateItem(UpdateBranchRequest request);
        public Task<long> createItem(CreateBranchRequest request);
        public Task<int> deleteItem(int id);
    }
}
