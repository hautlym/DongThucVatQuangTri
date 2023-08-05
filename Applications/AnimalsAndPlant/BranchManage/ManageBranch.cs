using DongThucVatQuangTri.Applications.Animals.BranchAnimalManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.BranchManage.Dtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Models.EF;
using DongThucVatQuangTri.Models.Entities;
using Microsoft.EntityFrameworkCore;

namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.BranchManage
{
    public class ManageBranch : IManageBranch
    {
        private readonly DongThucVatContext _context;
        public ManageBranch(DongThucVatContext context)
        {
            _context = context;
        }

        public async Task<long> createItem(CreateBranchRequest request)
        {
            var branch = new DtvNganh()
            {
                Name = request.Name,
                NameLatinh = request.NameLatinh,
                Status = request.Status,
                UpdatedAt = request.UpdatedAt,
                CreatedAt = request.CreatedAt,
                UpdatedBy = request.UpdatedBy,
                CreatedBy = request.CreatedBy,
                Loai = request.Loai,
            };
            _context.DtvNganh.Add(branch);
            await _context.SaveChangesAsync();
            return branch.Id;
        }

        public async Task<int> deleteItem(int id)
        {
            var branch = await _context.DtvNganh.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (branch == null) 
                return -1;
            _context.DtvNganh.Remove(branch);
            return await _context.SaveChangesAsync();
        }

        public Task<List<BranchViewModel>> getAllItem()
        {
            throw new NotImplementedException();
            //var listItem = from b in _context.DtvNganh
            //               join u in _context.App
        }

        public Task<PageResult<BranchViewModel>> GetAlllPaging(GetBranchRequest request)
        {
            throw new NotImplementedException();
        }

        public Task<BranchViewModel> getItemById(int id)
        {
            throw new NotImplementedException();
        }

        public Task<BranchViewModel> getItemByName(string name)
        {
            throw new NotImplementedException();
        }

        public async Task<int> updateItem(UpdateBranchRequest request)
        {
            var branch =await _context.DtvNganh.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
            if (branch == null)
                return -1;
            branch.Status = request.Status;
            branch.Name = request.Name;
            branch.NameLatinh = request.NameLatinh;
            branch.UpdatedBy = request.UpdatedBy;
            branch.UpdatedAt= request.UpdatedAt;
            _context.DtvNganh.Update(branch);
            return await _context.SaveChangesAsync();
        }

    }
}
