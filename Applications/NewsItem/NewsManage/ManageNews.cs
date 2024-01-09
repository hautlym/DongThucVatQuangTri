using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Banners.Dtos.BannerDtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.NewsItem.Dtos.NewsDtos;
using DongThucVatQuangTri.Applications.Tours.Dtos;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using DongThucVatQuangTri.Models.EF;
using DongThucVatQuangTri.Models.Entities;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System.Xml.Linq;

namespace DongThucVatQuangTri.Applications.NewsItem.NewsManage
{
    public class ManageNews : IManageNews
    {
        private readonly DongThucVatContext _context;
        private readonly IManageFile _manageFile;
        public ManageNews(DongThucVatContext context, IManageFile manageFile)
        {
            _context = context;
            _manageFile = manageFile;

        }

        public async Task<int> ChangeIsHot(ChangeIsHotRequest request)
        {
            var news = await _context.News.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
            if (news == null)
                return -1;
            news.IsHot = request.IsHot;
            _context.News.Update(news);
            return await _context.SaveChangesAsync();
        }

        public async Task<int> ChangeStatus(ChangeStatusRequest request)
        {
            var news = await _context.News.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
            if (news == null)
                return -1;
            news.Status = request.status;
            _context.News.Update(news);
            return await _context.SaveChangesAsync();
        }

        public async Task<long> CreateNews(CreateNewsRequest request)
        {
            var checkExist = _context.News.Where(x=>x.Name == request.Name|| x.Alias==request.Alias).FirstOrDefault();
            if (checkExist != null)
                return -1;
            var item = new News()
            {
                Alias = request.Alias,
                RootNewsCatId = request.RootNewsCatId,
                NewsCatId = request.NewsCatId,
                Name = request.Name,
                Image = request.Image != null ? await _manageFile.SaveFile(request.Image) : "",
                ShortDescription = request.ShortDescription,
                Description = request.Description,
                SortOrder = request.SortOrder,
                IsHot = request.IsHot,
                IsSystem = request.IsSystem,
                Status = request.Status,
                Author = request.Author,
                Source = request.Source,
                PostAt = DateTime.Now,
                TitleSeo = request.TitleSeo,
                ContentSeo = request.ContentSeo,
                KeySeo =request.KeySeo,
                Language = request.Language,
                IdRelated = request.IdRelated,
            };
            _context.News.Add(item);
            await _context.SaveChangesAsync();
            return item.Id;
        }

        public async Task<int> deleteNews(int id)
        {
            var news = await _context.News.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (news == null)
                return -1;
            if (!String.IsNullOrEmpty(news.Image))
            {
                _manageFile.DeleteFile(news.Image);
            }
            _context.News.Remove(news);
            return await _context.SaveChangesAsync();
        }

        public async Task<List<NewsViewModels>> getAll()
        {
            var data = await _context.News.Select(request => new NewsViewModels()
            {
                Id = request.Id,
                Alias = request.Alias,
                RootNewsCatId = request.RootNewsCatId,
                NewsCatId = request.NewsCatId,
                Name = request.Name,
                Image = request.Image,
                ShortDescription = request.ShortDescription,
                Description = request.Description,
                SortOrder = request.SortOrder,
                IsHot = request.IsHot,
                IsSystem = request.IsSystem,
                Status = request.Status,
                Author = request.Author,
                Source = request.Source,
                PostAt = request.PostAt,
                TitleSeo = request.TitleSeo,
                ContentSeo = request.ContentSeo,
                KeySeo = request.KeySeo,
                Language = request.Language,
                IdRelated = request.IdRelated,
            }).ToListAsync();
            return data;
        }

        public async Task<ApiResult<PageResult<NewsViewModels>>> GetAlllPaging(GetNewsPagingRequest request)
        {
            var query = from b in _context.News
                        join bc in _context.NewsCat on b.NewsCatId equals Convert.ToInt32(bc.Id)
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
                .Select(request => new NewsViewModels()
                {
                    Id= request.b.Id,
                    Alias = request.b.Alias,
                    RootNewsCatId = request.b.RootNewsCatId,
                    NewsCatId = request.b.NewsCatId,
                    Name = request.b.Name,
                    Image = request.b.Image,
                    ShortDescription = request.b.ShortDescription,
                    Description = request.b.Description,
                    SortOrder = request.b.SortOrder,
                    IsHot = request.b.IsHot,
                    IsSystem = request.b.IsSystem,
                    Status = request.b.Status,
                    Author = request.b.Author,
                    Source = request.b.Source,
                    PostAt = request.b.PostAt,
                    TitleSeo = request.b.TitleSeo,
                    ContentSeo = request.b.ContentSeo,
                    KeySeo = request.b.KeySeo,
                    Language = request.b.Language,
                    IdRelated = request.b.IdRelated,
                    NewsCatName = request.bc.Name
                }).ToListAsync();
            var pageResult = new PageResult<NewsViewModels>
            {
                TotalRecords = totalRow,
                Items = data,
                PageIndex = request.PageIndex,
                PageSize = request.PageSize,
            };
            return new ApiSuccessResult<PageResult<NewsViewModels>>(pageResult);
        }

        public async Task<NewsViewModels> getNewsById(long id)
        {
            var query = from b in _context.News
                        join bc in _context.NewsCat on b.NewsCatId equals Convert.ToInt32(bc.Id)
                        where b.Id == id
                        select new { b, bc };
            //var bannerCat = await _context.Banner.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (await query.CountAsync() == 0)
            {
                return null;
            }
            var NewsVm = await query.Select(request => new NewsViewModels()
            {
                Id = request.b.Id,
                Alias = request.b.Alias,
                RootNewsCatId = request.b.RootNewsCatId,
                NewsCatId = request.b.NewsCatId,
                NewsCatName = request.bc.Name,
                Name = request.b.Name,
                Image = request.b.Image,
                ShortDescription = request.b.ShortDescription,
                Description = request.b.Description,
                SortOrder = request.b.SortOrder,
                IsHot = request.b.IsHot,
                IsSystem = request.b.IsSystem,
                Status = request.b.Status,
                Author = request.b.Author,
                Source = request.b.Source,
                PostAt = request.b.PostAt,
                TitleSeo = request.b.TitleSeo,
                ContentSeo = request.b.ContentSeo,
                KeySeo = request.b.KeySeo,
                Language = request.b.Language,
                IdRelated = request.b.IdRelated,
            }).FirstOrDefaultAsync();
            return NewsVm;
        }

        public async Task<int> IncreaseView(int id)
        {
            var news = await _context.News.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (news == null)
                return -1;
            news.TotalView +=1 ;
            _context.News.Update(news);
            return await _context.SaveChangesAsync();
        }

        public async Task<ApiResult<PageResult<NewsViewModels>>> PublicNewsPaging(GetNewsPagingRequest request)
        {
            var query = from b in _context.News
                        join bc in _context.NewsCat on b.NewsCatId equals Convert.ToInt32(bc.Id)
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
            
            var tempdata = await query.Select(request => new NewsViewModels()
                {
                    Id = request.b.Id,
                    Alias = request.b.Alias,
                    RootNewsCatId = request.b.RootNewsCatId,
                    NewsCatId = request.b.NewsCatId,
                    Name = request.b.Name,
                    Image = request.b.Image,
                    ShortDescription = request.b.ShortDescription,
                    Description = request.b.Description,
                    SortOrder = request.b.SortOrder,
                    IsHot = request.b.IsHot,
                    IsSystem = request.b.IsSystem,
                    Status = request.b.Status,
                    Author = request.b.Author,
                    Source = request.b.Source,
                    PostAt = request.b.PostAt,
                    TitleSeo = request.b.TitleSeo,
                    ContentSeo = request.b.ContentSeo,
                    KeySeo = request.b.KeySeo,
                    Language = request.b.Language,
                    IdRelated = request.b.IdRelated,
                    NewsCatName = request.bc.Name
                }).ToListAsync();
            if (request.type != 0)
            {
                var listnewData = new List<NewsViewModels>();
                if (request.type == 2)
                {
                    foreach (var item in tempdata)
                    {
                        var vqgLoai = _context.News.Where(x => x.Id == item.Id).ToList();
                        if (vqgLoai.Count > 0)
                        {
                            foreach (var item2 in vqgLoai)
                            {
                                var checkRoleUser = _context.appUsers.Where(x => x.Id.ToString() == item2.Author).Select(x => x.Roles).FirstOrDefault();
                                if (checkRoleUser == "NationParkMuongTe")
                                {
                                    listnewData.Add(item);
                                    break;
                                }
                            }
                        }
                    }
                }
                if (request.type == 1)
                {
                    foreach (var item in tempdata)
                    {
                        var vqgLoai = _context.News.Where(x => x.Id == item.Id).ToList();
                        if (vqgLoai.Count > 0)
                        {
                            foreach (var item2 in vqgLoai)
                            {
                                var checkRoleUser = _context.appUsers.Where(x => x.Id.ToString() == item2.Author).Select(x => x.Roles).FirstOrDefault();
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
            int totalRow = tempdata.Count;
            var data = tempdata.Skip((request.PageIndex - 1) * request.PageSize).Take(request.PageSize).ToList();
            var pageResult = new PageResult<NewsViewModels>
            {
                TotalRecords = totalRow,
                Items = data,
                PageIndex = request.PageIndex,
                PageSize = request.PageSize,
            };
            return new ApiSuccessResult<PageResult<NewsViewModels>>(pageResult);
        }

        public async Task<int> updateNews(UpdateNewsRequest request)
        {
            var news = await _context.News.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
            if (news == null)
                return -1;
            
            if (request.IsDelete == true)
            {
                if (!String.IsNullOrEmpty(news.Image))
                {
                    _manageFile.DeleteFile(news.Image);
                }
                news.Image = "";
            }
            if (request.Image != null)
            {
                if (!String.IsNullOrEmpty(news.Image))
                {
                    _manageFile.DeleteFile(news.Image);
                }
                news.Image = await _manageFile.SaveFile(request.Image);
            }
            news.NewsCatId = request.NewsCatId;
            news.Name = request.Name;
            news.Alias = request.Alias;
            news.RootNewsCatId = request.RootNewsCatId;
            news.NewsCatId = request.NewsCatId;
            news.Name = request.Name;
            news.ShortDescription = request.ShortDescription;
            news.Description = request.Description;
            news.SortOrder = request.SortOrder;
            news.IsHot = request.IsHot;
            news.IsSystem = request.IsSystem;
            news.Status = request.Status;
            news.Author = request.Author;
            news.Source = request.Source;
            news.TitleSeo = request.TitleSeo;
            news.ContentSeo = request.ContentSeo;
            news.KeySeo = request.KeySeo;
            news.Language = request.Language;
            news.IdRelated = request.IdRelated;
            news.Status = request.Status;
            news.Language = request.Language;
            news.UpdatedAt = DateTime.Now;
            _context.News.Update(news);
            return await _context.SaveChangesAsync();
        }
    }
}
