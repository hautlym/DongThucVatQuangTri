using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Banners.Dtos.BannerCategoryDtos;
using DongThucVatQuangTri.Applications.Banners.Dtos.BannerDtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.Common.FileStorageEdit;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using DongThucVatQuangTri.Models.EF;
using DongThucVatQuangTri.Models.Entities;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System.Net.Http.Headers;
using System.Xml.Linq;

namespace DongThucVatQuangTri.Applications.Banners.ManageBanner
{
    public class ManageBanner : IManageBanner
    {
        private readonly DongThucVatContext _context;
        private readonly IStorageServiceEdit _manageFile;
        public ManageBanner(DongThucVatContext context, IStorageServiceEdit manageFile)
        {
            _context = context;
            _manageFile = manageFile;

        }
        public async Task<string> SaveFile(IFormFile file)
        {

            var originalFileName = ContentDispositionHeaderValue.Parse(file.ContentDisposition).FileName.Trim('"');
            var fileName = $"{Guid.NewGuid()}{Path.GetExtension(originalFileName)}";
            await _manageFile.SaveFileAsync(file.OpenReadStream(), "banner", fileName);
            return fileName;
        }
        public async Task<long> CreateBanner(CreateBannerRequest request)
        {
            var item = new Banner()
            {

                BannerCatId = request.BannerCatId,
                Name = request.Name,
                Src = request.Src != null ? await this.SaveFile(request.Src) : "",
                SrcMobile = request.SrcMobile != null ? await this.SaveFile(request.SrcMobile) : "",
                Link = request.Link,
                Width = request.Width,
                Height = request.Height,
                Type = request.Type,
                Status = request.Status,
                Multitext = request.Multitext,
                Description = request.Description,
                SortOrder = request.SortOrder,
                Language = request.Language,
                IdRelated = request.IdRelated,
                CreatedAt = DateTime.Now,
            };
            _context.Banner.Add(item);
            await _context.SaveChangesAsync();
            return item.Id;
        }

        public async Task<int> deleteBanner(int id)
        {
            var banner = await _context.Banner.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (banner == null)
                return -1;
            if (!String.IsNullOrEmpty(banner.Src))
            {
               await _manageFile.DeleteFileAsync("banner",banner.Src);
            }
            if (!String.IsNullOrEmpty(banner.Src))
            {
                await _manageFile.DeleteFileAsync("banner", banner.SrcMobile);
            }
            _context.Banner.Remove(banner);
            return await _context.SaveChangesAsync();
        }

        public async Task<ApiResult<PageResult<BannerViewModels>>> GetAlllPaging(GetBannerPagingRequest request)
        {
            var query = from b in _context.Banner
                        join bc in _context.BannerCat on b.BannerCatId equals bc.Id
                        select new { b, bc };
            var list = query.ToList();
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
                .Select(x => new BannerViewModels()
                {
                    Id = x.b.Id,
                    BannerCatId = x.b.BannerCatId,
                    Name = x.b.Name,
                    Src = x.b.Src,
                    SrcMobile = x.b.SrcMobile,
                    Link = x.b.Link,
                    Width = x.b.Width,
                    Height = x.b.Height,
                    Type = x.b.Type,
                    Status = x.b.Status,
                    Multitext = x.b.Multitext,
                    Description = x.b.Description,
                    SortOrder = x.b.SortOrder,
                    Language = x.b.Language,
                    IdRelated = x.b.IdRelated,
                    CreatedAt = x.b.CreatedAt,
                    UpdatedAt = x.b.UpdatedAt,
                    BannerCat = x.bc.Name,
                }).ToListAsync();
            var pageResult = new PageResult<BannerViewModels>
            {
                TotalRecords = totalRow,
                Items = data,
                PageIndex = request.PageIndex,
                PageSize = request.PageSize,
            };
            return new ApiSuccessResult<PageResult<BannerViewModels>>(pageResult);
        }

        public async Task<BannerViewModels> getBannerById(long id)
        {
            var query = from b in _context.Banner
                        join bc in _context.BannerCat on b.BannerCatId equals bc.Id
                        where b.Id == id
                        select new { b, bc };
            //var bannerCat = await _context.Banner.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (await query.CountAsync() == 0)
            {
                return null;
            }
            var BannerCateVm = await query.Select(x => new BannerViewModels()
            {
                Id = x.b.Id,
                BannerCatId = x.b.BannerCatId,
                Name = x.b.Name,
                Src = x.b.Src,
                SrcMobile = x.b.SrcMobile,
                Link = x.b.Link,
                Width = x.b.Width,
                Height = x.b.Height,
                Type = x.b.Type,
                Status = x.b.Status,
                Multitext = x.b.Multitext,
                Description = x.b.Description,
                SortOrder = x.b.SortOrder,
                Language = x.b.Language,
                IdRelated = x.b.IdRelated,
                CreatedAt = x.b.CreatedAt,
                UpdatedAt = x.b.UpdatedAt,
                BannerCat = x.bc.Name
            }).FirstOrDefaultAsync();
            return BannerCateVm;
        }

        public async Task<int> updateBanner(UpdateBannerRequest request)
        {
            var banner = await _context.Banner.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
            if (banner == null)
                return -1;
            banner.BannerCatId = request.BannerCatId;
            banner.Name = request.Name;
            if (request.isDelete == true)
            {
                if (!String.IsNullOrEmpty(banner.Src))
                {
                   await _manageFile.DeleteFileAsync("banner",banner.Src);
                }
                banner.Src = "";
            }
            if (request.Src != null)
            {
                if (!String.IsNullOrEmpty(banner.Src))
                {
                  await  _manageFile.DeleteFileAsync("banner",banner.Src);
                }
                banner.Src = await this.SaveFile(request.Src);
            }
            if (request.isDeleteMobile == true)
            {
                if (!String.IsNullOrEmpty(banner.SrcMobile))
                {
                  await  _manageFile.DeleteFileAsync("banner", banner.SrcMobile);
                }
                banner.SrcMobile = "";
            }
            if (request.SrcMobile != null)
            {
                if (!String.IsNullOrEmpty(banner.SrcMobile))
                {
                   await _manageFile.DeleteFileAsync("banner", banner.SrcMobile);
                }
                banner.SrcMobile = await this.SaveFile(request.SrcMobile);
            }
            banner.Link = request.Link;
            banner.Width = request.Width;
            banner.Height = request.Height;
            banner.Type = request.Type;
            banner.Status = request.Status;
            banner.Multitext = request.Multitext;
            banner.Description = request.Description;
            banner.SortOrder = request.SortOrder;
            banner.Language = request.Language;
            banner.IdRelated = request.IdRelated;
            banner.UpdatedAt = DateTime.Now;
            _context.Banner.Update(banner);
            return await _context.SaveChangesAsync();
        }
        public async Task<int> ChangeStatus(ChangeStatusRequest request)
        {
            var banner = await _context.Banner.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
            if (banner == null)
                return -1;
            banner.Status = request.status;
            _context.Banner.Update(banner);
            return await _context.SaveChangesAsync();
        }
        public async Task<int> ChangeSortOrder(ChangeSortOrderRequest request)
        {
            var banner = await _context.Banner.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
            if (banner == null)
                return -1;
            banner.SortOrder = request.sortOrder;
            _context.Banner.Update(banner);
            return await _context.SaveChangesAsync();
        }

        public async Task<List<BannerViewModels>> GetAll()
        {
            var data = await _context.Banner.Select(banner => new BannerViewModels()
            {
                Id = banner.Id,
                Name = banner.Name,
                Src = banner.Src,
                Status = banner.Status,
                SortOrder = banner.SortOrder,
            }).ToListAsync();
            return data;
        }
    }
}
