using DongThucVatQuangTri.Applications.AnimalsAndPlant.SetManage.Dtos;
using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using DongThucVatQuangTri.Models.EF;
using DongThucVatQuangTri.Models.Entities;
using Microsoft.EntityFrameworkCore;

namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.SetManage
{
    public class ManageSet : IManageSet
    {
        private readonly DongThucVatContext _context;
        public ManageSet(DongThucVatContext context)
        {
            _context = context;
        }

        public async Task<int> ChangeStatus(ChangeStatusRequest request)
        {
            var item = await _context.DtvBo.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
            if (item == null)
                return -1;
            item.Status = request.status;
            _context.DtvBo.Update(item);
            return await _context.SaveChangesAsync();
        }

        public async Task<long> createItem(CreateSetRequest request)
        {
            var item2 = _context.DtvBo.Where(x => x.NameLatinh.Equals(request.NameLatinh.Trim().ToUpper())).FirstOrDefault();
            if (item2 != null) return -2;
            var item = new DtvBo()
            {
                IdDtvLop = request.IdDtvLop,
                Name = request.Name,
                NameLatinh = request.NameLatinh.Trim().ToUpper(),
                Status = request.Status,
                CreatedAt = DateTime.Now,
                UpdatedAt = DateTime.Now,
                CreatedBy = request.CreatedBy,
                Loai = request.Loai,
            };
            _context.DtvBo.Add(item);
            await _context.SaveChangesAsync();
            return item.Id;
        }

        public async Task<int> deleteItem(int id)
        {
            var item = await _context.DtvBo.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (item == null)
                return -1;
            var child = _context.DtvHo.Where(x => x.IdDtvBo == item.Id).ToList();
            if (child.Count > 0)
            {
                return -1;
            }
            _context.DtvBo.Remove(item);
            return await _context.SaveChangesAsync();
        }

        public async Task<List<SetViewModels>> getAllItem()
        {
            var data = await _context.DtvBo.Select(request => new SetViewModels()
            {
                Id = request.Id,
                IdDtvLop = request.IdDtvLop,
                Name = request.Name,
                NameLatinh = request.NameLatinh,
                Status = request.Status,
                UpdatedAt = request.UpdatedAt,
                CreatedAt = request.CreatedAt,
                Loai = request.Loai,
                CreatedBy = request.CreatedBy,
                UpdatedBy = request.UpdatedBy,

            }).ToListAsync();
            return data;
        }

        public async Task<ApiResult<PageResult<SetViewModels>>> GetAlllPaging(GetSetRequest request, bool isAdmin = false)
        {
            var query = from b in _context.DtvBo
                        join n in _context.DtvLop on (long)b.IdDtvLop equals n.Id
                        select new { b, n };
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
                .Select(x => new SetViewModels()
                {
                    Id = x.b.Id,
                    IdDtvLop = x.b.IdDtvLop,
                    NameLop = x.n.Name,
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
            var pageResult = new PageResult<SetViewModels>
            {
                TotalRecords = totalRow,
                Items = data,
                PageIndex = request.PageIndex,
                PageSize = request.PageSize,
            };
            return new ApiSuccessResult<PageResult<SetViewModels>>(pageResult);
        }

        public async Task<SetViewModels> getItemById(int id)
        {
            var query = from b in _context.DtvBo
                        join l in _context.DtvLop on b.IdDtvLop equals (int)l.Id
                        where b.Id == id
                        select new { b, l };
            var item = await query.FirstOrDefaultAsync();
            if (item == null)
            {
                return null;
            }
            var lopVm = new SetViewModels()
            {
                Id = item.b.Id,
                IdDtvLop = item.b.IdDtvLop,
                Name = item.b.Name,
                NameLop = item.l.Name,
                NameLatinh = item.b.NameLatinh,
                Status = item.b.Status,
                Loai = item.b.Loai,
                CreatedAt = item.b.CreatedAt,
                UpdatedAt = item.b.UpdatedAt,
                CreatedBy = item.b.CreatedBy,
                UpdatedBy = item.b.UpdatedBy,
                NameCreate = _context.appUsers.Where(c => c.Id.ToString().Equals(item.b.CreatedBy)).Select(x => x.FirstName).FirstOrDefault()
            };
            return lopVm;
        }

        public async Task<int> updateItem(UpdateSetRequest request)
        {
            var result = await _context.DtvBo.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
            if (result == null)
                return -1;

            var item2 = _context.DtvBo.Where(x => x.NameLatinh.Equals(request.NameLatinh.Trim().ToUpper())).FirstOrDefault();
            if (item2 != null && item2.NameLatinh != result.NameLatinh) return -2;

            result.Status = request.Status;
            result.IdDtvLop = request.IdDtvLop;
            result.Name = request.Name;
            result.NameLatinh = request.NameLatinh;
            result.UpdatedBy = request.UpdatedBy;
            result.UpdatedAt = DateTime.Now;
            _context.DtvBo.Update(result);
            return await _context.SaveChangesAsync();
        }
    }
}
