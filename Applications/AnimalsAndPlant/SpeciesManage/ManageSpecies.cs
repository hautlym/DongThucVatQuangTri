﻿using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage.Dtos;
using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using DongThucVatQuangTri.Models.EF;
using DongThucVatQuangTri.Models.Entities;
using Microsoft.EntityFrameworkCore;
using System.Security.Policy;

namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage
{
    public class ManageSpecies : IManageSpecies
    {
        private readonly DongThucVatContext _context;
        private readonly IManageFile _manageFile;
        public ManageSpecies(DongThucVatContext context, IManageFile manageFile)
        {
            _context = context;
            _manageFile = manageFile;
        }

        public async Task<int> ChangeStatus(ChangeStatusRequest request)
        {
            var item = await _context.DtvLoai.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
            if (item == null)
                return -1;
            item.Status = request.status;
            _context.DtvLoai.Update(item);
            return await _context.SaveChangesAsync();
        }

        public async Task<long> createItem(CreateSpeciesRequest request)
        {
            try
            {
                var item = new DtvLoai()
                {
                    IdDtvHo = request.IdDtvHo,
                    Name = request.Name,
                    NameLatinh = request.NameLatinh,
                    Status = request.Status,
                    CreatedAt = DateTime.Now,
                    UpdatedAt = DateTime.Now,
                    CreatedBy = request.CreatedBy,
                    Loai = request.Loai,
                    GiaTriSuDung = request.GiaTriSuDung,
                    NguonTaiLieu = request.NguonTaiLieu,
                    FileDinhKem = request.FileDinhKem != null ? await SaveMultipleFileAsync(request.FileDinhKem) : "",
                    DacDiem = request.DacDiem,
                    MucDoBaoTonIucn = request.MucDoBaoTonIucn,
                    MucDoBaoTonNd64cp = request.MucDoBaoTonNd64cp,
                    MucDoBaoTonNdcp = request.MucDoBaoTonNdcp,
                    MucDoBaoTonSdvn = request.MucDoBaoTonSdvn,
                    PhanBo = request.PhanBo,
                    TenKhac = request.TenKhac,
                };
                _context.DtvLoai.Add(item);
                await _context.SaveChangesAsync();
                return item.Id;

            }
            catch (Exception ex)
            {
                return -1;
            }
        }
        public async Task<string> SaveMultipleFileAsync(List<IFormFile> list)
        {
            string url;
            List<string> listUrl = new List<string>();
            foreach (var item in list)
            {
                url = await _manageFile.SaveFile(item);
                listUrl.Add(url);
            }
            url = string.Join(",", listUrl);
            return url;
        }
        public async Task<int> deleteItem(int id)
        {
            var lop = await _context.DtvLoai.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (lop == null)
                return -1;
            _context.DtvLoai.Remove(lop);
            return await _context.SaveChangesAsync();
        }

        //public async Task<List<FamilyViewModels>> getAllItem()
        //{
        //    var data = await _context.DtvHo.Select(request => new FamilyViewModels()
        //    {
        //        Id = request.Id,
        //        IdDtvBo = request.IdDtvBo,
        //        Name = request.Name,
        //        NameLatinh = request.NameLatinh,
        //        Status = request.Status,
        //        UpdatedAt = request.UpdatedAt,
        //        CreatedAt = request.CreatedAt,
        //        Loai = request.Loai,
        //    }).ToListAsync();
        //    return data;
        //}

        public async Task<ApiResult<PageResult<SpeciesViewModels>>> GetAlllPaging(GetSpeciesRequest request)
        {
            var query = from b in _context.DtvLoai
                        join n in _context.DtvHo on (long)b.IdDtvHo equals n.Id
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
                .Select(x => new SpeciesViewModels()
                {
                    Id = x.b.Id,
                    IdDtvHo = x.b.IdDtvHo,
                    NameHo = x.n.Name,
                    Name = x.b.Name,
                    NameLatinh = x.b.NameLatinh,
                    Status = x.b.Status,
                    Loai = x.b.Loai,
                    CreatedAt = x.b.CreatedAt,
                    UpdatedAt = x.b.UpdatedAt,
                    GiaTriSuDung = x.b.GiaTriSuDung,
                    NguonTaiLieu = x.b.NguonTaiLieu,
                    FileDinhKem = x.b.FileDinhKem,
                    DacDiem = x.b.DacDiem,
                    MucDoBaoTonIucn = x.b.MucDoBaoTonIucn,
                    MucDoBaoTonNd64cp = x.b.MucDoBaoTonNd64cp,
                    MucDoBaoTonNdcp = x.b.MucDoBaoTonNdcp,
                    MucDoBaoTonSdvn = x.b.MucDoBaoTonSdvn,
                    PhanBo = x.b.PhanBo,
                    TenKhac = x.b.TenKhac,
                }).ToListAsync();
            var pageResult = new PageResult<SpeciesViewModels>
            {
                TotalRecords = totalRow,
                Items = data,
                PageIndex = request.PageIndex,
                PageSize = request.PageSize,
            };
            return new ApiSuccessResult<PageResult<SpeciesViewModels>>(pageResult);
        }

        public async Task<SpeciesViewModels> getItemById(int id)
        {
            var item = await _context.DtvLoai.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (item == null)
            {
                return null;
            }
            var lopVm = new SpeciesViewModels()
            {
                Id = item.Id,
                IdDtvHo = item.IdDtvHo,
                Name = item.Name,
                NameLatinh = item.NameLatinh,
                Status = item.Status,
                Loai = item.Loai,
                CreatedAt = item.CreatedAt,
                UpdatedAt = item.UpdatedAt,
                GiaTriSuDung = item.GiaTriSuDung,
                NguonTaiLieu = item.NguonTaiLieu,
                FileDinhKem = item.FileDinhKem,
                DacDiem = item.DacDiem,
                MucDoBaoTonIucn = item.MucDoBaoTonIucn,
                MucDoBaoTonNd64cp = item.MucDoBaoTonNd64cp,
                MucDoBaoTonNdcp = item.MucDoBaoTonNdcp,
                MucDoBaoTonSdvn = item.MucDoBaoTonSdvn,
                PhanBo = item.PhanBo,
                TenKhac = item.TenKhac,
            };
            return lopVm;
        }

        public async Task<int> updateItem(UpdateSpeciesRequest request)
        {
            try
            {
                var result = await _context.DtvLoai.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
                if (result == null)
                    return -1;
                if (request.isDelete)
                {
                    result.FileDinhKem = "";
                }
                if (request.FileDinhKem != null)
                {
                    string url = result.FileDinhKem;
                    result.FileDinhKem = result.FileDinhKem + "," + await SaveMultipleFileAsync(request.FileDinhKem);
                }
                result.Status = request.Status;
                result.IdDtvHo = request.IdDtvHo;
                result.Name = request.Name;
                result.NameLatinh = request.NameLatinh;
                result.UpdatedBy = request.UpdatedBy;
                result.UpdatedAt = DateTime.Now;
                result.GiaTriSuDung = request.GiaTriSuDung;
                result.NguonTaiLieu = request.NguonTaiLieu;
                result.DacDiem = request.DacDiem;
                result.MucDoBaoTonIucn = request.MucDoBaoTonIucn;
                result.MucDoBaoTonNd64cp = request.MucDoBaoTonNd64cp;
                result.MucDoBaoTonNdcp = request.MucDoBaoTonNdcp;
                result.MucDoBaoTonSdvn = request.MucDoBaoTonSdvn;
                result.PhanBo = request.PhanBo;
                result.TenKhac = request.TenKhac;
                _context.DtvLoai.Update(result);
                return await _context.SaveChangesAsync();
            }catch(Exception ex)
            {
                return -1;
            }
        }
    }
}