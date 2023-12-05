using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage.Dtos;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage.DtosPublic;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.Enums;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using DongThucVatQuangTri.Models.EF;
using DongThucVatQuangTri.Models.Entities;
using Microsoft.EntityFrameworkCore;

namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage
{
    public class PublicManageSpecies : IPublicManageSpecies
    {
        private readonly DongThucVatContext _context;
        public PublicManageSpecies(DongThucVatContext context)
        {
            _context = context;
        }
        public async Task<List<SpeciesPublicViewModel>> getAllItem()
        {
            var query = from l in _context.DtvLoai
                        select new { l };

            var data = await query.Select(item => new SpeciesPublicViewModel()
            {
                Id = item.l.Id,
                IdDtvHo = item.l.IdDtvHo,
                Name = item.l.Name,
                NameLatinh = item.l.NameLatinh,
                Status = item.l.Status,
                Loai = item.l.Loai,
                CreatedAt = item.l.CreatedAt,
                UpdatedAt = item.l.UpdatedAt,
                //GiaTriSuDung = item.ln.GiaTriSuDung,
                //NguonTaiLieu = item.ln.NguonTaiLieu,
                //FileDinhKem = item.ln.FileDinhKem,
                //DacDiem = item.ln.DacDiem,
                MucDoBaoTonIucn = item.l.MucDoBaoTonIucn,
                MucDoBaoTonNd64cp = item.l.MucDoBaoTonNd64cp,
                MucDoBaoTonNdcp = item.l.MucDoBaoTonNdcp,
                MucDoBaoTonSdvn = item.l.MucDoBaoTonSdvn,
                FileDinhKem = _context.DtvLoai_VQGs.Where(z => z.IdDtvLoai == item.l.Id).Select(k => k.FileDinhKem)
                    .Count() > 0 ? String.Join(",", _context.DtvLoai_VQGs.Where(z => z.IdDtvLoai == item.l.Id).Select(k => k.FileDinhKem).ToList()) : ""
                //PhanBo = item.ln.PhanBo,
                //TenKhac = item.ln.TenKhac,
            }).ToListAsync();
            return data;
        }

        public async Task<ApiResult<PageResult<SpeciesPublicViewModel>>> GetAlllPaging(getSpeciesPublicRequest request)
        {
            var query =
                        from b in _context.DtvLoai
                        join n in _context.DtvHo on (long)b.IdDtvHo equals n.Id
                        join bo in _context.DtvBo on (long)n.IdDtvBo equals bo.Id
                        join lop in _context.DtvLop on (long)bo.IdDtvLop equals lop.Id
                        join nganh in _context.DtvNganh on (long)lop.IdDtvNganh equals nganh.Id
                        select new { b, n, bo, lop, nganh };
            if (request.loai == 1 || request.loai == 0)
            {
                query = query.Where(x => x.b.Loai == request.loai);
            }
            if (!string.IsNullOrEmpty(request.keyword))
            {
                query = query.Where(x => x.b.Name.Contains(request.keyword) || x.b.NameLatinh.Contains(request.keyword));
            }
            if (!string.IsNullOrEmpty(request.keyword2))
            {
                query = query.Where(x => x.b.NameLatinh.Contains(request.keyword2));
            }
            if (request.status == 1 || request.status == 0)
            {
                query = query.Where(x => x.b.Status == 1);
            }
            if (request.icun != 0)
            {
                query = query.Where(x => x.b.MucDoBaoTonIucn == request.icun);
            }
            if (request.nd64cp != 0)
            {
                query = query.Where(x => x.b.MucDoBaoTonNd64cp == request.nd64cp);
            }
            if (request.ndcp != 0)
            {
                query = query.Where(x => x.b.MucDoBaoTonNdcp == request.ndcp);
            }
            if (request.sdvn != 0)
            {
                query = query.Where(x => x.b.MucDoBaoTonSdvn == request.sdvn);
            }
            if (request.id_ho != 0)
            {
                query = query.Where(x => x.n.Id == request.id_ho);
            }
            if (request.id_bo != 0)
            {
                query = query.Where(x => x.bo.Id == request.id_bo);
            }
            if (request.id_lop != 0)
            {
                query = query.Where(x => x.lop.Id == request.id_lop);
            }
            if (request.id_nganh != 0)
            {
                query = query.Where(x => x.nganh.Id == request.id_nganh);
            }
            var tempdata =await query.Select(x => new SpeciesPublicViewModel()
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
                CreatedBy = x.b.CreatedBy,
                UpdatedBy = x.b.UpdatedBy,
                MucDoBaoTonIucn = x.b.MucDoBaoTonIucn,
                MucDoBaoTonNd64cp = x.b.MucDoBaoTonNd64cp,
                MucDoBaoTonNdcp = x.b.MucDoBaoTonNdcp,
                MucDoBaoTonSdvn = x.b.MucDoBaoTonSdvn,
                FileDinhKem = _context.DtvLoai_VQGs.Where(z => z.IdDtvLoai == x.b.Id).Select(k => k.FileDinhKem)
                    .Count() > 0 ? String.Join(",", _context.DtvLoai_VQGs.Where(z => z.IdDtvLoai == x.b.Id).Select(k => k.FileDinhKem).ToList()) : ""
            }).ToListAsync();
            if (request.vqg != 0)
            {
                var listnewData = new List<SpeciesPublicViewModel>();
                if (request.vqg == 1)
                {
                    foreach (var item in tempdata)
                    {
                        var vqgLoai = _context.DtvLoai_VQGs.Where(x => x.IdDtvLoai == item.Id).ToList();
                        if (vqgLoai.Count > 0)
                        {
                            foreach (var item2 in vqgLoai)
                            {
                                var checkRoleUser = _context.appUsers.Where(x => x.Id.ToString() == item2.CreatedBy).Select(x => x.Roles).FirstOrDefault();
                                if (checkRoleUser == "NationParkMuongTe")
                                {
                                    listnewData.Add(item);
                                    break;
                                }
                            }
                        }
                    }
                }
                if (request.vqg == 2)
                {
                    foreach (var item in tempdata)
                    {
                        var vqgLoai = _context.DtvLoai_VQGs.Where(x => x.IdDtvLoai == item.Id).ToList();
                        if (vqgLoai.Count > 0)
                        {
                            foreach (var item2 in vqgLoai)
                            {
                                var checkRoleUser = _context.appUsers.Where(x => x.Id.ToString() == item2.CreatedBy).Select(x => x.Roles).FirstOrDefault();
                                if (checkRoleUser == "NationParkNamGiang")
                                {
                                    listnewData.Add(item);
                                    break;
                                }
                            }
                        }
                    }
                }
                tempdata = listnewData;
            }
            int totalRow =  tempdata.Count;
            var data = tempdata.Skip((request.PageIndex - 1) * request.PageSize).Take(request.PageSize).ToList();
                //.Select(x => new SpeciesPublicViewModel()
                //{
                //    Id = x.b.Id,
                //    IdDtvHo = x.b.IdDtvHo,
                //    NameHo = x.n.Name,
                //    Name = x.b.Name,
                //    NameLatinh = x.b.NameLatinh,
                //    Status = x.b.Status,
                //    Loai = x.b.Loai,
                //    CreatedAt = x.b.CreatedAt,
                //    UpdatedAt = x.b.UpdatedAt,
                //    CreatedBy = x.b.CreatedBy,
                //    UpdatedBy = x.b.UpdatedBy,
                //    MucDoBaoTonIucn = x.b.MucDoBaoTonIucn,
                //    MucDoBaoTonNd64cp = x.b.MucDoBaoTonNd64cp,
                //    MucDoBaoTonNdcp = x.b.MucDoBaoTonNdcp,
                //    MucDoBaoTonSdvn = x.b.MucDoBaoTonSdvn,
                //    FileDinhKem = _context.DtvLoai_VQGs.Where(z => z.IdDtvLoai == x.b.Id).Select(k => k.FileDinhKem)
                //    .Count() > 0 ? String.Join(",", _context.DtvLoai_VQGs.Where(z => z.IdDtvLoai == x.b.Id).Select(k => k.FileDinhKem).ToList()) : ""
                //}).ToListAsync();
            
            var pageResult = new PageResult<SpeciesPublicViewModel>
            {
                TotalRecords = totalRow,
                Items = data,
                PageIndex = request.PageIndex,
                PageSize = request.PageSize,
            };
            return new ApiSuccessResult<PageResult<SpeciesPublicViewModel>>(pageResult);
        }

        public async Task<DetailPublicSpeciesModel> getItemById(int id)
        {
            var query = from l in _context.DtvLoai
                        join f in _context.DtvHo on l.IdDtvHo equals (int)f.Id
                        where l.Id == id
                        select new { l, f };
            var item = await query.FirstOrDefaultAsync();
            if (item == null)
            {
                return null;
            }
            var listVQG = _context.DtvLoai_VQGs.Where(x => x.IdDtvLoai == id).ToList();
            
            //DtvLoai_VQG dtvLoai_VQG = new DtvLoai_VQG();
            //var i = 1;
            //foreach (var item2 in listVQG)
            //{
            //    if (i == listVQG.Count)
            //    {
            //        dtvLoai_VQG.FileDinhKem += item2.FileDinhKem;
            //        dtvLoai_VQG.NguonTaiLieu += item2.NguonTaiLieu;
            //        dtvLoai_VQG.TenKhac += item2.TenKhac;
            //        dtvLoai_VQG.PhanBo += item2.PhanBo;
            //        dtvLoai_VQG.DacDiem += item2.DacDiem;
            //        dtvLoai_VQG.GiaTriSuDung += item2.GiaTriSuDung;
            //    }
            //    else
            //    {
            //        dtvLoai_VQG.FileDinhKem += String.IsNullOrEmpty(item2.FileDinhKem) ? "" : item2.FileDinhKem + ", ";
            //        dtvLoai_VQG.NguonTaiLieu += String.IsNullOrEmpty(item2.NguonTaiLieu) ? "" : item2.NguonTaiLieu + ", ";
            //        dtvLoai_VQG.TenKhac += String.IsNullOrEmpty(item2.TenKhac) ? "" : item2.TenKhac + ", ";
            //        dtvLoai_VQG.PhanBo += String.IsNullOrEmpty(item2.PhanBo) ? "" : item2.PhanBo + ", ";
            //        dtvLoai_VQG.DacDiem += String.IsNullOrEmpty(item2.DacDiem) ? "" : item2.DacDiem + ", ";
            //        dtvLoai_VQG.GiaTriSuDung += String.IsNullOrEmpty(item2.GiaTriSuDung) ? "" : item2.GiaTriSuDung + ", ";
            //    }
            //    i++;
            //}
            var lopVm = new DetailPublicSpeciesModel()
            {
                Id = item.l.Id,
                IdDtvHo = item.l.IdDtvHo,
                Name = item.l.Name,
                NameLatinh = item.l.NameLatinh,
                Status = item.l.Status,
                Loai = item.l.Loai,
                //GiaTriSuDung = dtvLoai_VQG.GiaTriSuDung,
                //NguonTaiLieu = dtvLoai_VQG.NguonTaiLieu,
                //FileDinhKem = dtvLoai_VQG.FileDinhKem,
                //DacDiem = dtvLoai_VQG.DacDiem,
                MucDoBaoTonIucn = item.l.MucDoBaoTonIucn,
                MucDoBaoTonNd64cp = item.l.MucDoBaoTonNd64cp,
                MucDoBaoTonNdcp = item.l.MucDoBaoTonNdcp,
                MucDoBaoTonSdvn = item.l.MucDoBaoTonSdvn,
                //PhanBo = dtvLoai_VQG.PhanBo,
                //TenKhac = dtvLoai_VQG.TenKhac,
                NameHo = item.f.Name,
                
            };
            if (listVQG.Count > 0)
            {
                foreach (var item2 in listVQG)
                {
                    var checkRoleUser = _context.appUsers.Where(x => x.Id.ToString() == item2.CreatedBy).Select(x => x.Roles).FirstOrDefault();
                    if (checkRoleUser == "NationParkNamGiang")
                    {
                        lopVm.VQgNamGiang = item2;
                    }
                    if (checkRoleUser == "NationParkMuongTe")
                    {
                        lopVm.VQGMuongTe = item2;
                    }
                }
            }
            return lopVm;
        }
    }
}
