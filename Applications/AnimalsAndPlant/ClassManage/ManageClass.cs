﻿using DongThucVatQuangTri.Applications.AnimalsAndPlant.BranchManage.Dtos;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.ClassManage.Dtos;
using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using DongThucVatQuangTri.Models.EF;
using DongThucVatQuangTri.Models.Entities;
using Microsoft.EntityFrameworkCore;

namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.ClassManage
{
    public class ManageClass:IManageClass
    {
        private readonly DongThucVatContext _context;
        public ManageClass(DongThucVatContext context)
        {
            _context = context;
        }

        public async Task<int> ChangeStatus(ChangeStatusRequest request)
        {
            var branch = await _context.DtvLop.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
            if (branch == null)
                return -1;
            branch.Status = request.status;
            _context.DtvLop.Update(branch);
            return await _context.SaveChangesAsync();
        }

        public async Task<long> createItem(CreateClassRequest request)
        {
            var lop = new DtvLop()
            {
                IdDtvNganh = request.IdDtvNganh,
                Name = request.Name,
                NameLatinh = request.NameLatinh,
                Status = request.Status,
                CreatedAt = DateTime.Now,
                UpdatedAt = DateTime.Now,
                CreatedBy = request.CreatedBy,
                Loai = request.Loai,
            };
            _context.DtvLop.Add(lop);
            await _context.SaveChangesAsync();
            return lop.Id;
        }

        public async Task<int> deleteItem(int id)
        {
            var lop = await _context.DtvLop.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (lop == null)
                return -1;
            _context.DtvLop.Remove(lop);
            return await _context.SaveChangesAsync();
        }

        public async Task<List<ClassViewModels>> getAllItem()
        {
            var data = await _context.DtvLop.Select(request => new ClassViewModels()
            {
                Id = request.Id,
                IdDtvNganh = request.IdDtvNganh,
                Name = request.Name,
                NameLatinh = request.NameLatinh,
                Status = request.Status,
                UpdatedAt = request.UpdatedAt,
                CreatedAt = request.CreatedAt,
                Loai = request.Loai,
            }).ToListAsync();
            return data;
        }

        public async Task<ApiResult<PageResult<ClassViewModels>>> GetAlllPaging(GetClassRequest request)
        {
            var query = from b in _context.DtvLop
                        join n in _context.DtvNganh on  (long)b.IdDtvNganh equals n.Id
                        select new { b,n};
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
                .Select(x => new ClassViewModels()
                {
                    Id = x.b.Id,
                    IdDtvNganh = x.b.IdDtvNganh,
                    DtvNganhName = x.n.Name,
                    Name = x.b.Name,
                    NameLatinh = x.b.NameLatinh,
                    Status = x.b.Status,
                    Loai = x.b.Loai,
                    CreatedAt = x.b.CreatedAt,
                    UpdatedAt = x.b.UpdatedAt,
                }).ToListAsync();
            var pageResult = new PageResult<ClassViewModels>
            {
                TotalRecords = totalRow,
                Items = data,
                PageIndex = request.PageIndex,
                PageSize = request.PageSize,
            };
            return new ApiSuccessResult<PageResult<ClassViewModels>>(pageResult);
        }

        public async Task<ClassViewModels> getItemById(int id)
        {
            var lop = await _context.DtvLop.Where(x => x.Id == id).FirstOrDefaultAsync(); 
            if (lop == null)
            {
                return null;
            }
            var lopVm = new ClassViewModels()
            {
                Id = lop.Id,
                IdDtvNganh = lop.IdDtvNganh,
                Name = lop.Name,
                NameLatinh = lop.NameLatinh,
                Status = lop.Status,
                Loai = lop.Loai,
                CreatedAt = lop.CreatedAt,
                UpdatedAt = lop.UpdatedAt,
            };
            return lopVm;
        }

        public async Task<int> updateItem(UpdateClassRequest request)
        {
            var result = await _context.DtvLop.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
            if (result == null)
                return -1;
            result.Status = request.Status;
            result.IdDtvNganh = request.IdDtvNganh;
            result.Name = request.Name;
            result.NameLatinh = request.NameLatinh;
            result.UpdatedBy = request.UpdatedBy;
            result.UpdatedAt = DateTime.Now;
            _context.DtvLop.Update(result);
            return await _context.SaveChangesAsync();
        }
    }
}