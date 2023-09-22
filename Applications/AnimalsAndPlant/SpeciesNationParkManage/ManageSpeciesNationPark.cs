using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage.Dtos;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesNationParkManage.Dtos;
using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using DongThucVatQuangTri.Models.EF;
using DongThucVatQuangTri.Models.Entities;
using Microsoft.EntityFrameworkCore;

namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesNationParkManage
{
    public class ManageSpeciesNationPark : IManageSpeciesNationPark
    {
        private readonly DongThucVatContext _context;
        private readonly IManageFile _manageFile;
        public ManageSpeciesNationPark(DongThucVatContext context, IManageFile manageFile)
        {
            _context = context;
            _manageFile = manageFile;
        }
        public async Task<int> ChangeStatus(ChangeStatusRequest request)
        {
            var item = await _context.DtvLoai_VQGs.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
            if (item == null)
                return -1;
            item.Status = request.status;
            _context.DtvLoai_VQGs.Update(item);
            return await _context.SaveChangesAsync();
        }

        public async Task<long> createItem(CreateSpeciesNationParkRequest request)
        {
            try
            {
                var item = new DtvLoai_VQG()
                {
                    IdDtvLoai = request.IdDtvLoai,
                    Status = request.Status,
                    CreatedAt = DateTime.Now,
                    Loai = request.Loai,
                    UpdatedAt = DateTime.Now,
                    CreatedBy = request.CreatedBy,
                    GiaTriSuDung = request.GiaTriSuDung,
                    NguonTaiLieu = request.NguonTaiLieu,
                    FileDinhKem = request.FileDinhKem != null ? await SaveMultipleFileAsync(request.FileDinhKem) : "",
                    DacDiem = request.DacDiem,
                    PhanBo = request.PhanBo,
                    TenKhac = request.TenKhac,
                };
                _context.DtvLoai_VQGs.Add(item);
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
            var loai = await _context.DtvLoai_VQGs.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (loai == null)
                return -1;
            if (!String.IsNullOrEmpty(loai.FileDinhKem))
            {
                foreach (var item in loai.FileDinhKem.Split(','))
                {
                    if (!String.IsNullOrEmpty(item))
                    {
                        _manageFile.DeleteFile(item);
                    }
                }
            }
            _context.DtvLoai_VQGs.Remove(loai);
            return await _context.SaveChangesAsync();
        }

        public async Task<List<SpeciesNationParkViewModel>> getAllItem()
        {
            var data = await _context.DtvLoai_VQGs.Select(item => new SpeciesNationParkViewModel()
            {
                Id = item.Id,
                Status = item.Status,
                Loai = item.Loai,
                CreatedAt = item.CreatedAt,
                UpdatedAt = item.UpdatedAt,
                GiaTriSuDung = item.GiaTriSuDung,
                NguonTaiLieu = item.NguonTaiLieu,
                FileDinhKem = item.FileDinhKem,
                DacDiem = item.DacDiem,
                PhanBo = item.PhanBo,
                TenKhac = item.TenKhac,
            }).ToListAsync();
            return data;
        }

        public async Task<ApiResult<PageResult<SpeciesNationParkViewModel>>> GetAlllPaging(getSpeciesNationParkRequest request)
        {
            var query = from lv in _context.DtvLoai_VQGs
                        join b in _context.DtvLoai on lv.IdDtvLoai equals b.Id
                        join n in _context.DtvHo on (long)b.IdDtvHo equals n.Id
                        select new { lv, b, n };
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
                .Select(x => new SpeciesNationParkViewModel()
                {
                    Id = x.lv.Id,
                    IdDtvHo = x.b.IdDtvHo,
                    NameHo = x.n.Name,
                    Name = x.b.Name,
                    NameLatinh = x.b.NameLatinh,
                    Status = x.b.Status,
                    Loai = x.b.Loai,
                    CreatedAt = x.b.CreatedAt,
                    UpdatedAt = x.b.UpdatedAt,
                    GiaTriSuDung = x.lv.GiaTriSuDung,
                    NguonTaiLieu = x.lv.NguonTaiLieu,
                    FileDinhKem = x.lv.FileDinhKem,
                    DacDiem = x.lv.DacDiem,
                    MucDoBaoTonIucn = x.b.MucDoBaoTonIucn,
                    MucDoBaoTonNd64cp = x.b.MucDoBaoTonNd64cp,
                    MucDoBaoTonNdcp = x.b.MucDoBaoTonNdcp,
                    MucDoBaoTonSdvn = x.b.MucDoBaoTonSdvn,
                    PhanBo = x.lv.PhanBo,
                    TenKhac = x.lv.TenKhac,
                }).ToListAsync();
            var pageResult = new PageResult<SpeciesNationParkViewModel>
            {
                TotalRecords = totalRow,
                Items = data,
                PageIndex = request.PageIndex,
                PageSize = request.PageSize,
            };
            return new ApiSuccessResult<PageResult<SpeciesNationParkViewModel>>(pageResult);
        }

        public async Task<SpeciesNationParkViewModel> getItemById(int id)
        {
            var query = from lv in _context.DtvLoai_VQGs
                        join l in _context.DtvLoai on lv.IdDtvLoai equals l.Id
                        where lv.Id == id
                        select new { lv, l};
            var item = await query.FirstOrDefaultAsync();
            if (item == null)
            {
                return null;
            }
            var lopVm = new SpeciesNationParkViewModel()
            {
                Id = item.lv.Id,
                IdDtvHo = item.l.IdDtvHo,
                Name = item.l.Name,
                NameLatinh = item.l.NameLatinh,
                IdDtvLoai= item.lv.IdDtvLoai,
                Status = item.l.Status,
                Loai = item.l.Loai,
                CreatedAt = item.lv.CreatedAt,
                UpdatedAt = item.lv.UpdatedAt,
                CreatedBy = item.lv.CreatedBy,
                UpdatedBy = item.lv.UpdatedBy,
                GiaTriSuDung = item.lv.GiaTriSuDung,
                NguonTaiLieu = item.lv.NguonTaiLieu,
                FileDinhKem = item.lv.FileDinhKem,
                DacDiem = item.lv.DacDiem,
                MucDoBaoTonIucn = item.l.MucDoBaoTonIucn,
                MucDoBaoTonNd64cp = item.l.MucDoBaoTonNd64cp,
                MucDoBaoTonNdcp = item.l.MucDoBaoTonNdcp,
                MucDoBaoTonSdvn = item.l.MucDoBaoTonSdvn,
                PhanBo = item.lv.PhanBo,
                TenKhac = item.lv.TenKhac,
            };
            return lopVm;
        }

        public async Task<int> updateItem(UpdateSpeciesNationParkRequest request)
        {
            try
            {
                var result = await _context.DtvLoai_VQGs.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
                if (result == null)
                    return -1;
                if (request.isDelete)
                {
                    if (!String.IsNullOrEmpty(result.FileDinhKem))
                    {
                        foreach (var item in result.FileDinhKem.Split(','))
                        {
                            if (!String.IsNullOrEmpty(item))
                            {
                                _manageFile.DeleteFile(item);
                            }
                        }
                    }
                    result.FileDinhKem = "";
                }
                if (request.FileDinhKem != null)
                {
                    string url = result.FileDinhKem;
                    result.FileDinhKem = result.FileDinhKem + "," + await SaveMultipleFileAsync(request.FileDinhKem);
                }
                result.IdDtvLoai = request.IdDtvLoai;
                result.Status = request.Status;
                result.UpdatedBy = request.UpdatedBy;
                result.UpdatedAt = DateTime.Now;
                result.GiaTriSuDung = request.GiaTriSuDung;
                result.NguonTaiLieu = request.NguonTaiLieu;
                result.DacDiem = request.DacDiem;
                result.PhanBo = request.PhanBo;
                result.TenKhac = request.TenKhac;
                _context.DtvLoai_VQGs.Update(result);
                return await _context.SaveChangesAsync();
            }
            catch (Exception ex)
            {
                return -1;
            }
        }
    }
}
