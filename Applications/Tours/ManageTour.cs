using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage.DtosPublic;
using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.NewsItem.Dtos.NewsDtos;
using DongThucVatQuangTri.Applications.Tours.Dtos;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using DongThucVatQuangTri.Models.EF;
using DongThucVatQuangTri.Models.Entities;
using Microsoft.EntityFrameworkCore;

namespace DongThucVatQuangTri.Applications.Tours
{
    public class ManageTour : IManageTour
    {
        private readonly DongThucVatContext _context;
        private readonly IManageFile _manageFile;
        public ManageTour(DongThucVatContext context, IManageFile manageFile)
        {
            _context = context;
            _manageFile = manageFile;

        }
        public async Task<int> ChangeStatus(ChangeStatusRequest request)
        {
            var tour = await _context.tour.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
            if (tour == null)
                return -1;
            tour.Status = request.status;
            _context.tour.Update(tour);
            return await _context.SaveChangesAsync();
        }

        public async Task<long> CreateTour(CreateTourRequest request)
        {
            var item = new Tour()
            {
                Alias = request.Alias,
                Name = request.Name,
                Image = request.Image != null ? await _manageFile.SaveFile(request.Image) : "",
                ShortDescription = request.ShortDescription,
                Description = request.Description,
                SortOrder = request.SortOrder,
                Status = request.Status,
                Author = request.Author,
                Source = request.Source,
                CreatedAt = DateTime.Now,
            };
            _context.tour.Add(item);
            await _context.SaveChangesAsync();
            return item.Id;
        }

        public async Task<int> deleteTour(int id)
        {
            var news = await _context.tour.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (news == null)
                return -1;
            if (!String.IsNullOrEmpty(news.Image))
            {
                _manageFile.DeleteFile(news.Image);
            }
            _context.tour.Remove(news);
            return await _context.SaveChangesAsync();
        }

        public Task<List<TourViewModel>> getAll()
        {
            throw new NotImplementedException();
        }

        public async Task<ApiResult<PageResult<TourViewModel>>> GetAlllPaging(GetTourPagingRequest request)
        {
            var query = from b in _context.tour
                        select new { b };
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
                .Select(request => new TourViewModel()
                {
                    Id = request.b.Id,
                    Alias = request.b.Alias,
                    Name = request.b.Name,
                    Image = request.b.Image,
                    ShortDescription = request.b.ShortDescription,
                    Description = request.b.Description,
                    SortOrder = request.b.SortOrder,
                    Status = request.b.Status,
                    Author = _context.appUsers.Where(x => x.Id.ToString() == request.b.Author).Select(x => x.FirstName).FirstOrDefault(),
                    Source = request.b.Source,
                    CreatedAt = request.b.CreatedAt,
                    UpdatedAt = request.b.UpdatedAt
                }).ToListAsync();
            var pageResult = new PageResult<TourViewModel>
            {
                TotalRecords = totalRow,
                Items = data,
                PageIndex = request.PageIndex,
                PageSize = request.PageSize,
            };
            return new ApiSuccessResult<PageResult<TourViewModel>>(pageResult);
        }

        public async Task<TourViewModel> getTourById(long id)
        {
            var query = from b in _context.tour
                        where b.Id == id
                        select new { b };
            //var bannerCat = await _context.Banner.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (await query.CountAsync() == 0)
            {
                return null;
            }
            var NewsVm = await query.Select(request => new TourViewModel()
            {
                Id = request.b.Id,
                Alias = request.b.Alias,
                Name = request.b.Name,
                Image = request.b.Image,
                ShortDescription = request.b.ShortDescription,
                Description = request.b.Description,
                SortOrder = request.b.SortOrder,
                Status = request.b.Status,
                Author = _context.appUsers.Where(x => x.Id.ToString() == request.b.Author).Select(x => x.FirstName).FirstOrDefault(),
                Source = request.b.Source,
                CreatedAt = request.b.CreatedAt,
                UpdatedAt = request.b.UpdatedAt
            }).FirstOrDefaultAsync();
            return NewsVm;
        }

        public async Task<int> IncreaseView(int id)
        {
            var news = await _context.tour.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (news == null)
                return -1;
            news.TotalView += 1;
            _context.tour.Update(news);
            return await _context.SaveChangesAsync();
        }

        public async Task<ApiResult<PageResult<TourViewModel>>> PublicTourPaging(GetTourPagingRequest request)
        {
            var query = from b in _context.tour
                        select new { b };
            var list = query.ToList();
            if (!string.IsNullOrEmpty(request.Keyword))
            {
                query = query.Where(x => x.b.Name.Contains(request.Keyword));
            }
            if (request.status == 1 || request.status == 0)
            {
                query = query.Where(x => x.b.Status == request.status);
            }
            
            var tempdata =await query.Select(request => new TourViewModel()
                {
                    Id = request.b.Id,
                    Alias = request.b.Alias,
                    Name = request.b.Name,
                    Image = request.b.Image,
                    ShortDescription = request.b.ShortDescription,
                    Description = request.b.Description,
                    SortOrder = request.b.SortOrder,
                    Status = request.b.Status,
                    //Author = _context.appUsers.Where(x => x.Id.ToString() == request.b.Author).Select(x => x.FirstName).FirstOrDefault(),
                    Source = request.b.Source,
                    CreatedAt = request.b.CreatedAt,
                    UpdatedAt = request.b.UpdatedAt
                }).ToListAsync();
            if(request.type!=0)
            {
                var listnewData = new List<TourViewModel>();
                if (request.type == 2)
                {
                    foreach (var item in tempdata)
                    {
                        var vqgLoai = _context.tour.Where(x => x.Id == item.Id).ToList();
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
                        var vqgLoai = _context.tour.Where(x => x.Id == item.Id).ToList();
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
            var pageResult = new PageResult<TourViewModel>
            {
                TotalRecords = totalRow,
                Items = data,
                PageIndex = request.PageIndex,
                PageSize = request.PageSize,
            };
            return new ApiSuccessResult<PageResult<TourViewModel>>(pageResult);
        }

        public async Task<int> updateTour(UpdateTourRequest request)
        {
            var news = await _context.tour.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
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
            news.Name = request.Name;
            news.Alias = request.Alias;
            news.Name = request.Name;
            news.ShortDescription = request.ShortDescription;
            news.Description = request.Description;
            news.SortOrder = request.SortOrder;
            news.Status = request.Status;
            news.Source = request.Source;
            news.Status = request.Status;
            news.UpdatedAt = DateTime.Now;
            _context.tour.Update(news);
            return await _context.SaveChangesAsync();
        }

    }
}
