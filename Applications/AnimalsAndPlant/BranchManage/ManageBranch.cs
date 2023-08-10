using DongThucVatQuangTri.Applications.AnimalsAndPlant.BranchManage.Dtos;
using DongThucVatQuangTri.Applications.Banners.Dtos.BannerCategoryDtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using DongThucVatQuangTri.Models.EF;
using DongThucVatQuangTri.Models.Entities;
using Microsoft.EntityFrameworkCore;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

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

        public async Task<List<BranchViewModel>> getAllItem()
        {
            var data = await _context.DtvNganh.Select(request => new BranchViewModel()
            {
                Name = request.Name,
                NameLatinh = request.NameLatinh,
                Status = request.Status,
                UpdatedAt = request.UpdatedAt,
                CreatedAt = request.CreatedAt,
                Loai = request.Loai,
            }).ToListAsync();
            return data;
        }

        public async Task<ApiResult<PageResult<BranchViewModel>>> GetAlllPaging(GetBranchRequest request)
        {
            var query = from b in _context.DtvNganh
                           select new { b};
            if(request.loai == 1 || request.loai == 0)
            {
                query = query.Where(x => x.b.Loai == request.loai);
            }    
            if (!string.IsNullOrEmpty(request.keyword))
            {
                query = query.Where(x => x.b.Name.Contains(request.keyword) || x.b.NameLatinh.Contains(request.keyword));
            }
            if (request.status == 1 || request.status == 0)
            {
                query = query.Where(x => x.b.Status == request.status);
            }
            int totalRow = await query.CountAsync();
            var data = await query.Skip((request.PageIndex - 1) * request.PageSize).Take(request.PageSize)
                .Select(x => new BranchViewModel()
                {
                    Id = x.b.Id,
                    Name = x.b.Name,
                    NameLatinh = x.b.NameLatinh,
                    Status = x.b.Status,
                    Loai = x.b.Loai,
                    CreatedAt = x.b.CreatedAt,
                    UpdatedAt = x.b.UpdatedAt,
                }).ToListAsync();
            var pageResult = new PageResult<BranchViewModel>
            {
                TotalRecords = totalRow,
                Items = data,
                PageIndex = request.PageIndex,
                PageSize = request.PageSize,
            };
            return new ApiSuccessResult<PageResult<BranchViewModel>>(pageResult);
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
