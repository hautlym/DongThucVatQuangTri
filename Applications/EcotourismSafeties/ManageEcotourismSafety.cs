using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage.DtosPublic;
using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.Common.FileStorageEdit;
using DongThucVatQuangTri.Applications.EcotourismSafeties.Dtos;
using DongThucVatQuangTri.Applications.NewsItem.Dtos.NewsDtos;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using DongThucVatQuangTri.Models.EF;
using DongThucVatQuangTri.Models.Entities;
using Microsoft.EntityFrameworkCore;
using System.Net.Http.Headers;

namespace DongThucVatQuangTri.Applications.EcotourismSafeties
{
    public class ManageEcotourismSafety : IManageEcotourismSafety
    {
        private readonly DongThucVatContext _context;
        private readonly IStorageServiceEdit _manageFile;
        public ManageEcotourismSafety(DongThucVatContext context, IStorageServiceEdit manageFile)
        {
            _context = context;
            _manageFile = manageFile;

        }
        public async Task<string> SaveFile(IFormFile file)
        {
            var originalFileName = ContentDispositionHeaderValue.Parse(file.ContentDisposition).FileName.Trim('"');
            var fileName = $"{Guid.NewGuid()}{Path.GetExtension(originalFileName)}";
            await _manageFile.SaveFileAsync(file.OpenReadStream(), "EcotourismSafety", fileName);
            return fileName;
        }
        public async Task<int> ChangeStatus(ChangeStatusRequest request)
        {
            var tour = await _context.ecotourismSafeties.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
            if (tour == null)
                return -1;
            tour.Status = request.status;
            _context.ecotourismSafeties.Update(tour);
            return await _context.SaveChangesAsync();
        }

        public async Task<long> Create(CreateEcotourismSafetyRequest request)
        {
            var item = new EcotourismSafety()
            {
                Alias = request.Alias,
                Name = request.Name,
                Image = request.Image != null ? await SaveFile(request.Image) : "",
                ShortDescription = request.ShortDescription,
                Description = request.Description,
                SortOrder = request.SortOrder,
                Status = request.Status,
                Author = request.Author,
                Source = request.Source,
                CreatedAt = DateTime.Now,
                TypeNationPark = request.typeNationPark
            };
            _context.ecotourismSafeties.Add(item);
            await _context.SaveChangesAsync();
            return item.Id;
        }

        public async Task<int> delete(int id)
        {
            var news = await _context.ecotourismSafeties.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (news == null)
                return -1;
            if (!string.IsNullOrEmpty(news.Image))
            {
                await _manageFile.DeleteFileAsync("EcotourismSafety", news.Image);
            }
            _context.ecotourismSafeties.Remove(news);
            return await _context.SaveChangesAsync();
        }

        public Task<List<EcotourismSafetyViewModel>> getAll()
        {
            throw new NotImplementedException();
        }

        public async Task<ApiResult<PageResult<EcotourismSafetyViewModel>>> GetAlllPaging(GetEcotourismSafetyPagingRequest request)
        {
            var query = from b in _context.ecotourismSafeties
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
            if (!string.IsNullOrEmpty(request.typeNationPark))
            {
                query = query.Where(x => x.b.TypeNationPark == request.typeNationPark);
            }
            int totalRow = await query.CountAsync();
            var data = await query.Skip((request.PageIndex - 1) * request.PageSize).Take(request.PageSize)
                .Select(request => new EcotourismSafetyViewModel()
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
                    UpdatedAt = request.b.UpdatedAt,
                    typeNationPark = request.b.TypeNationPark
                }).ToListAsync();
            var pageResult = new PageResult<EcotourismSafetyViewModel>
            {
                TotalRecords = totalRow,
                Items = data,
                PageIndex = request.PageIndex,
                PageSize = request.PageSize,
            };
            return new ApiSuccessResult<PageResult<EcotourismSafetyViewModel>>(pageResult);
        }

        public async Task<EcotourismSafetyViewModel> getById(long id)
        {
            var query = from b in _context.ecotourismSafeties
                        where b.Id == id
                        select new { b };
            //var bannerCat = await _context.Banner.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (await query.CountAsync() == 0)
            {
                return null;
            }
            var NewsVm = await query.Select(request => new EcotourismSafetyViewModel()
            {
                Id = request.b.Id,
                Alias = request.b.Alias,
                Name = request.b.Name,
                Image = request.b.Image,
                ShortDescription = request.b.ShortDescription,
                Description = request.b.Description,
                SortOrder = request.b.SortOrder,
                Status = request.b.Status,
                NameCreate = _context.appUsers.Where(x => x.Id.ToString() == request.b.Author).Select(x => x.FirstName).FirstOrDefault(),
                Source = request.b.Source,
                Author = request.b.Author,
                CreatedAt = request.b.CreatedAt,
                UpdatedAt = request.b.UpdatedAt,
                typeNationPark = request.b.TypeNationPark
            }).FirstOrDefaultAsync();
            return NewsVm;
        }

        public async Task<int> IncreaseView(int id)
        {
            var news = await _context.ecotourismSafeties.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (news == null)
                return -1;
            news.TotalView += 1;
            _context.ecotourismSafeties.Update(news);
            return await _context.SaveChangesAsync();
        }

        public async Task<ApiResult<PageResult<EcotourismSafetyViewModel>>> PublicPaging(GetEcotourismSafetyPagingRequest request)
        {
            var query = from b in _context.ecotourismSafeties
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

            var tempdata = await query.Select(request => new EcotourismSafetyViewModel()
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
                UpdatedAt = request.b.UpdatedAt,
                typeNationPark = request.b.TypeNationPark

            }).ToListAsync();
            if (request.type != 0)
            {
                var listnewData = new List<EcotourismSafetyViewModel>();
                if (request.type == 2)
                {
                    foreach (var item in tempdata)
                    {
                        if (item.typeNationPark == "NationParkMuongTe")
                        {
                            listnewData.Add(item);

                        }
                    }
                }
                if (request.type == 1)
                {
                    foreach (var item in tempdata)
                    {
                        if (item.typeNationPark == "NationParkNamGiang")
                        {
                            listnewData.Add(item);

                        }
                    }
                }
                tempdata = listnewData;
            }
            int totalRow = tempdata.Count;
            var data = tempdata.OrderBy(x => x.CreatedAt).Skip((request.PageIndex - 1) * request.PageSize).Take(request.PageSize).ToList();
            var pageResult = new PageResult<EcotourismSafetyViewModel>
            {
                TotalRecords = totalRow,
                Items = data,
                PageIndex = request.PageIndex,
                PageSize = request.PageSize,
            };
            return new ApiSuccessResult<PageResult<EcotourismSafetyViewModel>>(pageResult);
        }

        public async Task<int> update(UpdateEcotourismSafetyRequest request)
        {
            var news = await _context.ecotourismSafeties.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
            if (news == null)
                return -1;

            if (request.IsDelete == true)
            {
                if (!string.IsNullOrEmpty(news.Image))
                {
                    await _manageFile.DeleteFileAsync("EcotourismSafety", news.Image);
                }
                news.Image = "";
            }
            if (request.Image != null)
            {
                if (!string.IsNullOrEmpty(news.Image))
                {
                    await _manageFile.DeleteFileAsync("EcotourismSafety", news.Image);
                }
                news.Image = await this.SaveFile(request.Image);
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
            news.TypeNationPark = request.typeNationPark;
            _context.ecotourismSafeties.Update(news);
            return await _context.SaveChangesAsync();
        }

    }
}
