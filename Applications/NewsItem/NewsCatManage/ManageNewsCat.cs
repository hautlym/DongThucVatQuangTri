using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Banners.Dtos.BannerCategoryDtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.Common.FileStorageEdit;
using DongThucVatQuangTri.Applications.NewsItem.Dtos.NewsCatDtos;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using DongThucVatQuangTri.Models.EF;
using DongThucVatQuangTri.Models.Entities;
using Microsoft.EntityFrameworkCore;
using System.Net.Http.Headers;

namespace DongThucVatQuangTri.Applications.NewsItem.NewsCatManage
{
    public class ManageNewsCat : IManageNewsCat
    {
        private readonly DongThucVatContext _context;
        private readonly IStorageServiceEdit _manageFile;
        public ManageNewsCat(DongThucVatContext context, IStorageServiceEdit manageFile)
        {
            _context = context;
            _manageFile = manageFile;

        }
        public async Task<string> SaveFile(IFormFile file)
        {
            var originalFileName = ContentDispositionHeaderValue.Parse(file.ContentDisposition).FileName.Trim('"');
            var fileName = $"{Guid.NewGuid()}{Path.GetExtension(originalFileName)}";
            await _manageFile.SaveFileAsync(file.OpenReadStream(), "news", fileName);
            return fileName;
        }
        public async Task<int> ChangeStatus(ChangeStatusRequest request)
        {
            var NewsCat = await _context.NewsCat.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
            if (NewsCat == null)
                return -1;
            NewsCat.Status = request.status;
            _context.NewsCat.Update(NewsCat);
            return await _context.SaveChangesAsync();
        }

        public async Task<long> CreateNewsCat(CreateNewsCatRequest request)
        {
            var item = new NewsCat()
            {
                Name = request.Name,
                ParentId = request.ParentId,
                Image = request.Image != null ? await this.SaveFile(request.Image) : "",
                Status = request.Status,
                Description = request.Description,
                SortOrder = request.SortOrder,
                Language = request.Language,
                IdRelated = request.IdRelated,
                CreatedAt = DateTime.Now,
                Alias = request.Alias,
                TitleSeo = request.TitleSeo,
                ContentSeo = request.ContentSeo,
                KeySeo = request.KeySeo
            };
            _context.NewsCat.Add(item);
            await _context.SaveChangesAsync();
            return item.Id;
        }

        public async Task<int> deleteNewsCat(int id)
        {
            var newscat = await _context.NewsCat.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (newscat == null)
                return -1;
            if (!String.IsNullOrEmpty(newscat.Image))
            {
               await _manageFile.DeleteFileAsync("news",newscat.Image);
            }
            _context.NewsCat.Remove(newscat);
            return await _context.SaveChangesAsync();
        }

        public async Task<List<NewsCatViewModels>> GetAll()
        {
            var data = await _context.NewsCat.Select(newscat => new NewsCatViewModels()
            {
                Id = newscat.Id,
                Alias = newscat.Alias,
                TitleSeo = newscat.TitleSeo,
                ContentSeo = newscat.ContentSeo,
                KeySeo = newscat.KeySeo,
                UpdateAt = newscat.UpdatedAt,
                Name = newscat.Name,
                ParentId = newscat.ParentId,
                CreateAt = newscat.CreatedAt,
                Image = newscat.Image,
                Status = newscat.Status,
                Description = newscat.Description,
                SortOrder = newscat.SortOrder,
                Language = newscat.Language,
                IdRelated = newscat.IdRelated,
            }).ToListAsync();
            return data;
        }

        public async Task<ApiResult<PageResult<NewsCatViewModels>>> GetAlllPaging(GetNewsCatPagingRequest request)
        {
            var query = from b in _context.NewsCat
                        select b;
            if (!string.IsNullOrEmpty(request.Keyword))
            {
                query = query.Where(x => x.Name.Contains(request.Keyword));
            }
            if (request.status == 1 || request.status == 0)
            {
                query = query.Where(x => x.Status == request.status);
            }
            int totalRow = await query.CountAsync();
            var data = await query.Skip((request.PageIndex - 1) * request.PageSize).Take(request.PageSize)
                .Select(newscat => new NewsCatViewModels()
                {
                    Id = newscat.Id,
                    Alias = newscat.Alias,
                    TitleSeo = newscat.TitleSeo,
                    ContentSeo = newscat.ContentSeo,
                    KeySeo = newscat.KeySeo,
                    UpdateAt = newscat.UpdatedAt,
                    Name = newscat.Name,
                    ParentId = newscat.ParentId,
                    CreateAt = newscat.CreatedAt,
                    Status = newscat.Status,
                    Description = newscat.Description,
                    Image = newscat.Image,
                    SortOrder = newscat.SortOrder,
                    Language = newscat.Language,
                    IdRelated = newscat.IdRelated,
                    ParentName = _context.NewsCat.Where(x => x.Id == newscat.ParentId).Select(x => x.Name).FirstOrDefault()
                }).ToListAsync();
            var pageResult = new PageResult<NewsCatViewModels>
            {
                TotalRecords = totalRow,
                Items = data,
                PageIndex = request.PageIndex,
                PageSize = request.PageSize,
            };
            return new ApiSuccessResult<PageResult<NewsCatViewModels>>(pageResult);
        }

        public async Task<NewsCatViewModels> getNewsCatById(int id)
        {
            var newscat = await _context.NewsCat.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (newscat == null)
            {
                return null;
            }
            var NewCats = new NewsCatViewModels()
            {
                Id = newscat.Id,
                Alias = newscat.Alias,
                TitleSeo = newscat.TitleSeo,
                ContentSeo = newscat.ContentSeo,
                ParentName = _context.NewsCat.Where(x => x.Id == newscat.ParentId).Select(x => x.Name).FirstOrDefault(),
                KeySeo = newscat.KeySeo,
                UpdateAt = newscat.UpdatedAt,
                Name = newscat.Name,
                ParentId = newscat.ParentId,
                CreateAt = newscat.CreatedAt,
                Image = newscat.Image,
                Status = newscat.Status,
                Description = newscat.Description,
                SortOrder = newscat.SortOrder,
                Language = newscat.Language,
                IdRelated = newscat.IdRelated,
            };
            return NewCats;
        }

        public async Task<int> updateNewsCat(UpdateNewsCatRequest request)
        {
            var newsCat = await _context.NewsCat.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
            if (newsCat == null)
                return -1;
            newsCat.Status = request.Status;
            newsCat.Name = request.Name;
            newsCat.Status = request.Status;
            newsCat.IdRelated = request.IdRelated;
            newsCat.Path = request.Path;
            if (request.isDelete == true)
            {
                if (!String.IsNullOrEmpty(newsCat.Image))
                {
                  await  _manageFile.DeleteFileAsync("news",newsCat.Image);
                }
                newsCat.Image = "";
            }
            if (request.Image != null)
            {
                if (!String.IsNullOrEmpty(newsCat.Image))
                {
                  await  _manageFile.DeleteFileAsync("news",newsCat.Image);
                }
                newsCat.Image = await this.SaveFile(request.Image);
            }
            newsCat.SortOrder = request.SortOrder;
            newsCat.Alias = request.Alias;
            newsCat.Language = request.Language;
            newsCat.IdRelated = request.IdRelated;
            newsCat.Path = request.Path;
            newsCat.TitleSeo = request.TitleSeo;
            newsCat.Description = request.Description;
            newsCat.ContentSeo = request.ContentSeo;
            newsCat.KeySeo = request.KeySeo;
            newsCat.UpdatedAt = DateTime.Now;
            newsCat.ParentId = request.ParentId;
            _context.NewsCat.Update(newsCat);
            return await _context.SaveChangesAsync();
        }
    }
}
