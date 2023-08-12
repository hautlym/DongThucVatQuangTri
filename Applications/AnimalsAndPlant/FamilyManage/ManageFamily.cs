using DongThucVatQuangTri.Applications.AnimalsAndPlant.ClassManage.Dtos;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.FamilyManage.Dtos;
using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using DongThucVatQuangTri.Models.EF;
using DongThucVatQuangTri.Models.Entities;
using Microsoft.EntityFrameworkCore;

namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.FamilyManage
{
    public class ManageFamily:IManageFamily
    {
        private readonly DongThucVatContext _context;
        public ManageFamily(DongThucVatContext context)
        {
            _context = context;
        }

        public async Task<int> ChangeStatus(ChangeStatusRequest request)
        {
            var item = await _context.DtvHo.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
            if (item == null)
                return -1;
            item.Status = request.status;
            _context.DtvHo.Update(item);
            return await _context.SaveChangesAsync();
        }

        public async Task<long> createItem(CreateFamilyRequest request)
        {
            var item = new DtvHo()
            {
                IdDtvBo = request.IdDtvBo,
                Name = request.Name,
                NameLatinh = request.NameLatinh,
                Status = request.Status,
                CreatedAt = DateTime.Now,
                UpdatedAt = DateTime.Now,
                CreatedBy = request.CreatedBy,
                Loai = request.Loai,
            };
            _context.DtvHo.Add(item);
            await _context.SaveChangesAsync();
            return item.Id;
        }

        public async Task<int> deleteItem(int id)
        {
            var lop = await _context.DtvHo.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (lop == null)
                return -1;
            _context.DtvHo.Remove(lop);
            return await _context.SaveChangesAsync();
        }

        public async Task<List<FamilyViewModels>> getAllItem()
        {
            var data = await _context.DtvHo.Select(request => new FamilyViewModels()
            {
                Id = request.Id,
                IdDtvBo = request.IdDtvBo,
                Name = request.Name,
                NameLatinh = request.NameLatinh,
                Status = request.Status,
                UpdatedAt = request.UpdatedAt,
                CreatedAt = request.CreatedAt,
                Loai = request.Loai,
            }).ToListAsync();
            return data;
        }

        public async Task<ApiResult<PageResult<FamilyViewModels>>> GetAlllPaging(GetFamilyRequest request)
        {
            var query = from b in _context.DtvHo
                        join n in _context.DtvBo on (long)b.IdDtvBo equals n.Id
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
                .Select(x => new FamilyViewModels()
                {
                    Id = x.b.Id,
                    IdDtvBo = x.b.IdDtvBo,
                    BoName = x.n.Name,
                    Name = x.b.Name,
                    NameLatinh = x.b.NameLatinh,
                    Status = x.b.Status,
                    Loai = x.b.Loai,
                    CreatedAt = x.b.CreatedAt,
                    UpdatedAt = x.b.UpdatedAt,
                }).ToListAsync();
            var pageResult = new PageResult<FamilyViewModels>
            {
                TotalRecords = totalRow,
                Items = data,
                PageIndex = request.PageIndex,
                PageSize = request.PageSize,
            };
            return new ApiSuccessResult<PageResult<FamilyViewModels>>(pageResult);
        }

        public async Task<FamilyViewModels> getItemById(int id)
        {
            var item = await _context.DtvHo.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (item == null)
            {
                return null;
            }
            var lopVm = new FamilyViewModels()
            {
                Id = item.Id,
                IdDtvBo = item.IdDtvBo,
                Name = item.Name,
                NameLatinh = item.NameLatinh,
                Status = item.Status,
                Loai = item.Loai,
                CreatedAt = item.CreatedAt,
                UpdatedAt = item.UpdatedAt,
            };
            return lopVm;
        }

        public async Task<int> updateItem(UpdateFamilyRequest request)
        {
            var result = await _context.DtvHo.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
            if (result == null)
                return -1;
            result.Status = request.Status;
            result.IdDtvBo = request.IdDtvBo;
            result.Name = request.Name;
            result.NameLatinh = request.NameLatinh;
            result.UpdatedBy = request.UpdatedBy;
            result.UpdatedAt = DateTime.Now;
            _context.DtvHo.Update(result);
            return await _context.SaveChangesAsync();
        }
    }
}
