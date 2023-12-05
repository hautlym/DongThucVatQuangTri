using DongThucVatQuangTri.Applications.AnimalsAndPlant.BranchManage.Dtos;
using DongThucVatQuangTri.Applications.Banners.Dtos;
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

        public async Task<int> ChangeStatus(ChangeStatusRequest request)
        {
            var branch = await _context.DtvNganh.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
            if (branch == null)
                return -1;
            branch.Status = request.status;
            _context.DtvNganh.Update(branch);
            return await _context.SaveChangesAsync();
        }

        public async Task<long> createItem(CreateBranchRequest request)
        {
            var item = _context.DtvNganh.Where(x => x.NameLatinh.Equals(request.NameLatinh.Trim().ToUpper())).FirstOrDefault();
            if (item != null) return -2;
            var branch = new DtvNganh()
            {
                Name = request.Name,
                NameLatinh = request.NameLatinh.Trim().ToUpper(),
                Status = request.Status,
                CreatedAt = DateTime.Now,
                UpdatedAt = DateTime.Now,
                CreatedBy = request.CreatedBy,
                UpdatedBy = request.UpdatedBy,
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
            var child = _context.DtvLop.Where(x => x.IdDtvNganh == branch.Id).ToList();
            if (child.Count > 0)
            {
                return -1;
            }
            _context.DtvNganh.Remove(branch);
            return await _context.SaveChangesAsync();
        }

        public async Task<List<BranchViewModel>> getAllItem()
        {
            var data = await _context.DtvNganh.Select(request => new BranchViewModel()
            {
                Id = request.Id,
                Name = request.Name,
                NameLatinh = request.NameLatinh,
                Status = request.Status,
                UpdatedAt = request.UpdatedAt,
                CreatedAt = request.CreatedAt,
                CreatedBy = request.CreatedBy,
                UpdatedBy = request.UpdatedBy,
                Loai = request.Loai,
            }).ToListAsync();
            return data;
        }

        public async Task<ApiResult<PageResult<BranchViewModel>>> GetAlllPaging(GetBranchRequest request)
        {
            var query = from b in _context.DtvNganh
                        select new { b };
            if (request.loai == 1 || request.loai == 0)
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
                    CreatedBy = x.b.CreatedBy,
                    UpdatedBy = x.b.UpdatedBy,
                    NameCreate = _context.appUsers.Where(c => c.Id.ToString().Equals(x.b.CreatedBy)).Select(x => x.FirstName).FirstOrDefault()
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

        public async Task<BranchViewModel> getItemById(int id)
        {
            //var LongId = Convert.ToInt64(id);

            var branchList = await _context.DtvNganh.ToListAsync();
            var branch = branchList.Where(x => x.Id == id).FirstOrDefault();
            if (branch == null)
            {
                return null;
            }
            var branchVm = new BranchViewModel()
            {
                Id = branch.Id,
                Name = branch.Name,
                NameLatinh = branch.NameLatinh,
                Status = branch.Status,
                Loai = branch.Loai,
                CreatedAt = branch.CreatedAt,
                UpdatedAt = branch.UpdatedAt,
                CreatedBy = branch.CreatedBy,
                UpdatedBy = branch.UpdatedBy,
                NameCreate = _context.appUsers.Where(c => c.Id.ToString().Equals(branch.CreatedBy)).Select(x => x.FirstName).FirstOrDefault(),
            };
            return branchVm;
        }

        public Task<BranchViewModel> getItemByName(string name)
        {
            throw new NotImplementedException();
        }

        public async Task<int> updateItem(UpdateBranchRequest request)
        {
            var item = _context.DtvNganh.Where(x => x.NameLatinh.Equals(request.NameLatinh)).FirstOrDefault();
            if (item != null)
                return -2;
            var branch = await _context.DtvNganh.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
            if (branch == null)
                return -1;
            branch.Status = request.Status;
            branch.Name = request.Name;
            branch.NameLatinh = request.NameLatinh;
            branch.UpdatedBy = request.UpdatedBy;
            branch.UpdatedAt = DateTime.Now;
            _context.DtvNganh.Update(branch);
            return await _context.SaveChangesAsync();
        }

    }
}
