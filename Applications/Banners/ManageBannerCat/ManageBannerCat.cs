using DongThucVatQuangTri.Applications.AnimalsAndPlant.BranchManage.Dtos;
using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Banners.Dtos.BannerCategoryDtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.Common.FileStorageEdit;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using DongThucVatQuangTri.Models.EF;
using DongThucVatQuangTri.Models.Entities;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using System.Net.Http.Headers;
using System.Reflection;

namespace DongThucVatQuangTri.Applications.Banners.ManageBannerCat
{
    public class ManageBannerCat : IManageBannerCat
    {
        private readonly DongThucVatContext _context;
        private readonly IStorageServiceEdit _uploadFile;
        public ManageBannerCat(DongThucVatContext context, IStorageServiceEdit uploadFile)
        {
            _context = context;
            _uploadFile = uploadFile;
        }
        public async Task<string> SaveFile(IFormFile file)
        {

            var originalFileName = ContentDispositionHeaderValue.Parse(file.ContentDisposition).FileName.Trim('"');
            var fileName = $"{Guid.NewGuid()}{Path.GetExtension(originalFileName)}";
            await _uploadFile.SaveFileAsync(file.OpenReadStream(), "banner", fileName);
            return fileName;
        }
        public async Task<int> ChangeStatus(ChangeStatusRequest request)
        {
            var bannerCat = await _context.BannerCat.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
            if (bannerCat == null)
                return -1;
            bannerCat.Status = request.status;
            _context.BannerCat.Update(bannerCat);
            return await _context.SaveChangesAsync();
        }

        public async Task<long> CreateBannerCat(CreateBannerCatRequest request)
        {
            var item = new BannerCat()
            {
                Name = request.Name,
                ParentId = request.ParentId,
                Path = request.Path,
                Level = request.Level,
                Image = request.Image != null ? await this.SaveFile(request.Image) : "",
                Status = request.Status,
                Description = request.Description,
                SortOrder = request.SortOrder,
                Language = request.Language,
                IdRelated = request.IdRelated,
                CreatedAt = DateTime.Now,
            };
            _context.BannerCat.Add(item);
            await _context.SaveChangesAsync();
            return item.Id;
        }

        public async Task<int> deleteBannerCat(int id)
        {
            var banner = await _context.BannerCat.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (banner == null)
                return -1;
            if (!String.IsNullOrEmpty(banner.Image))
            {
               await _uploadFile.DeleteFileAsync("banner",banner.Image);
            }
            _context.BannerCat.Remove(banner);
            return await _context.SaveChangesAsync();
        }

        public async Task<List<BannerCatViewModels>> GetAll()
        {
            var data = await _context.BannerCat.Select(bannerCat => new BannerCatViewModels()
            {
                Id = bannerCat.Id,
                UpdatedAt = bannerCat.UpdatedAt,
                Name = bannerCat.Name,
                ParentId = bannerCat.ParentId,
                Path = bannerCat.Path,
                Level = bannerCat.Level,
                Image = bannerCat.Image,
                Status = bannerCat.Status,
                Description = bannerCat.Description,
                SortOrder = bannerCat.SortOrder,
                Language = bannerCat.Language,
                IdRelated = bannerCat.IdRelated,
                CreatedAt = bannerCat.CreatedAt,
                
            }).ToListAsync();
            return data;
        }

        public async Task<ApiResult<PageResult<BannerCatViewModels>>> GetAlllPaging(GetBannerCatPagingRequest request)
        {
            var query = from b in _context.BannerCat
                        select new { b };
            if (!string.IsNullOrEmpty(request.Keyword))
            {
                query = query.Where(x => x.b.Name.Contains(request.Keyword));
            }
            if (request.status == 1 || request.status == 0)
            {
                query = query.Where(x => x.b.Status == request.status);
            }
            int totalRow = await query.CountAsync();
            var data = await query.Skip((request.PageIndex - 1) * request.PageSize).Take(request.PageSize)
                .Select(request => new BannerCatViewModels()
                {
                    Id = request.b.Id,
                    UpdatedAt = request.b.UpdatedAt,
                    Name = request.b.Name,
                    ParentId = request.b.ParentId,
                    Path = request.b.Path,
                    Level = request.b.Level,
                    Image = request.b.Image,
                    Status = request.b.Status,
                    Description = request.b.Description,
                    SortOrder = request.b.SortOrder,
                    Language = request.b.Language,
                    IdRelated = request.b.IdRelated,
                    CreatedAt = request.b.CreatedAt,
                    Parentname = _context.BannerCat.Where(x => x.Id == request.b.ParentId).Select(x => x.Name).FirstOrDefault()
                }).ToListAsync();
            var pageResult = new PageResult<BannerCatViewModels>
            {
                TotalRecords = totalRow,
                Items = data,
                PageIndex = request.PageIndex,
                PageSize = request.PageSize,
            };
            return new ApiSuccessResult<PageResult<BannerCatViewModels>>(pageResult);
        }

        public async Task<BannerCatViewModels> getBannerCatById(int id)
        {
            var bannerCat = await _context.BannerCat.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (bannerCat == null)
            {
                return null;
            }
            var BannerCateVm = new BannerCatViewModels()
            {
                Id = bannerCat.Id,
                UpdatedAt = bannerCat.UpdatedAt,
                Name = bannerCat.Name,
                ParentId = bannerCat.ParentId,
                Parentname = _context.BannerCat.Where(x => x.Id == bannerCat.ParentId).Select(x => x.Name).FirstOrDefault(),
                Path = bannerCat.Path,
                Level = bannerCat.Level,
                Image = bannerCat.Image,
                Status = bannerCat.Status,
                Description = bannerCat.Description,
                SortOrder = bannerCat.SortOrder,
                Language = bannerCat.Language,
                IdRelated = bannerCat.IdRelated,
                CreatedAt = bannerCat.CreatedAt,
            };
            return BannerCateVm;
        }
        public async Task<int> updateBannerCar(UpdateBannerCatRequest request)
        {
            var bannerCat = await _context.BannerCat.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
            if (bannerCat == null)
                return -1;
            bannerCat.Status = request.Status;
            bannerCat.Name = request.Name;
            bannerCat.Status = request.Status;
            bannerCat.IdRelated = request.IdRelated;
            bannerCat.Path = request.Path;
            if (request.isDelete==true)
            {
                if (!String.IsNullOrEmpty(bannerCat.Image))
                {
                   await _uploadFile.DeleteFileAsync("banner",bannerCat.Image);
                }
                bannerCat.Image ="" ;
            }
            if (request.Image != null)
            {
                if (!String.IsNullOrEmpty(bannerCat.Image))
                {
                   await _uploadFile.DeleteFileAsync("banner",bannerCat.Image);
                }
                bannerCat.Image = await this.SaveFile(request.Image);
            }
            bannerCat.SortOrder = request.SortOrder;
            bannerCat.Level = request.Level;
            bannerCat.UpdatedAt = DateTime.Now;
            bannerCat.ParentId = request.ParentId;
            _context.BannerCat.Update(bannerCat);
            return await _context.SaveChangesAsync();
        }
    }
}
