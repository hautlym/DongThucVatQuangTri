using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.Common.FileStorageEdit;
using DongThucVatQuangTri.Applications.NewsItem.Dtos.NewsCatDtos;
using DongThucVatQuangTri.Applications.Tours.TourCat;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using DongThucVatQuangTri.Models.EF;
using DongThucVatQuangTri.Models.Entities;
using Microsoft.EntityFrameworkCore;
using System.Net.Http.Headers;

namespace DongThucVatQuangTri.Applications.Tours
{
    public class ManageTourCat : IManageTourCat
    {
        private readonly DongThucVatContext _context;
        private readonly IStorageServiceEdit _manageFile;
        public ManageTourCat(DongThucVatContext context, IStorageServiceEdit manageFile)
        {
            _context = context;
            _manageFile = manageFile;

        }
        public async Task<string> SaveFile(IFormFile file)
        {
            var originalFileName = ContentDispositionHeaderValue.Parse(file.ContentDisposition).FileName.Trim('"');
            var fileName = $"{Guid.NewGuid()}{Path.GetExtension(originalFileName)}";
            await _manageFile.SaveFileAsync(file.OpenReadStream(), "tour", fileName);
            return fileName;
        }
        public async Task<int> ChangeStatus(ChangeStatusRequest request)
        {
            var NewsCat = await _context.tourCats.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
            if (NewsCat == null)
                return -1;
            NewsCat.Status = request.status;
            _context.tourCats.Update(NewsCat);
            return await _context.SaveChangesAsync();
        }

        public async Task<long> CreateTourCat(CreateTourCatRequest request)
        {
            var check = _context.tourCats.Where(x=>x.Name==request.Name).FirstOrDefault();
            if (check != null)
                return - 1;
            var item = new tourCat()
            {
                Name = request.Name,
                Image = request.Image != null ? await this.SaveFile(request.Image) : "",
                Status = request.Status,
                Description = request.Description,
                SortOrder = request.SortOrder,
                CreatedAt = DateTime.Now,
                Alias = request.Alias,
                TypeNationPark = request.typeNationPark,
                CreateBy = request.CreateBy,
                UpdatedAt = DateTime.Now,
            };
            _context.tourCats.Add(item);
            await _context.SaveChangesAsync();
            return item.Id;
        }

        public async Task<int> deleteTourCat(int id)
        {
            var newscat = await _context.tourCats.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (newscat == null)
                return -1;
            if (!String.IsNullOrEmpty(newscat.Image))
            {
                await _manageFile.DeleteFileAsync("tour", newscat.Image);
            }
            _context.tourCats.Remove(newscat);
            return await _context.SaveChangesAsync();
        }

        public async Task<List<TourCatViewModel>> GetAll()
        {
            var data = await _context.tourCats.Select(newscat => new TourCatViewModel()
            {
                Id = newscat.Id,
                Alias = newscat.Alias,
                UpdateAt = newscat.UpdatedAt,
                Name = newscat.Name,
                CreateAt = newscat.CreatedAt,
                Image = newscat.Image,
                Status = newscat.Status,
                Description = newscat.Description,
                SortOrder = newscat.SortOrder,
                typeNationPark = newscat.TypeNationPark,
                
            }).ToListAsync();
            return data;
        }

        public async Task<ApiResult<PageResult<TourCatViewModel>>> GetAlllPaging(getTourCatPagingRequest request)
        {
            var query = from b in _context.tourCats
                        select b;
            if (!string.IsNullOrEmpty(request.Keyword))
            {
                query = query.Where(x => x.Name.Contains(request.Keyword));
            }
            if (request.status == 1 || request.status == 0)
            {
                query = query.Where(x => x.Status == request.status);
            }
            if (!request.typeNationPark.Contains("Administator"))
            {
                query = query.Where(x => x.TypeNationPark == request.typeNationPark);
            }
            int totalRow = await query.CountAsync();
            var data = await query.Skip((request.PageIndex - 1) * request.PageSize).Take(request.PageSize)
                .Select(newscat => new TourCatViewModel()
                {
                    Id = newscat.Id,
                    Alias = newscat.Alias,
                    UpdateAt = newscat.UpdatedAt,
                    Name = newscat.Name,
                    CreateAt = newscat.CreatedAt,
                    Status = newscat.Status,
                    Description = newscat.Description,
                    Image = newscat.Image,
                    SortOrder = newscat.SortOrder,
                    typeNationPark = newscat.TypeNationPark,
                }).ToListAsync();
            var pageResult = new PageResult<TourCatViewModel>
            {
                TotalRecords = totalRow,
                Items = data,
                PageIndex = request.PageIndex,
                PageSize = request.PageSize,
            };
            return new ApiSuccessResult<PageResult<TourCatViewModel>>(pageResult);
        }

        public async Task<TourCatViewModel> getTourCatById(int id)
        {
            var newscat = await _context.tourCats.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (newscat == null)
            {
                return null;
            }
            var NewCats = new TourCatViewModel()
            {
                Id = newscat.Id,
                Alias = newscat.Alias,
                UpdateAt = newscat.UpdatedAt,
                Name = newscat.Name,
                CreateAt = newscat.CreatedAt,
                Image = newscat.Image,
                Status = newscat.Status,
                Description = newscat.Description,
                SortOrder = newscat.SortOrder,
                typeNationPark = newscat.TypeNationPark
            };
            return NewCats;
        }

        public async Task<int> updateTourCat(UpdateTourCatRequest request)
        {
            var newsCat = await _context.tourCats.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
            if (newsCat == null)
                return -1;
            newsCat.Status = request.Status;
            newsCat.Name = request.Name;
            newsCat.Status = request.Status;
            if (request.isDelete == true)
            {
                if (!String.IsNullOrEmpty(newsCat.Image))
                {
                    await _manageFile.DeleteFileAsync("tour", newsCat.Image);
                }
                newsCat.Image = "";
            }
            if (request.Image != null)
            {
                if (!String.IsNullOrEmpty(newsCat.Image))
                {
                    await _manageFile.DeleteFileAsync("tour", newsCat.Image);
                }
                newsCat.Image = await this.SaveFile(request.Image);
            }
            newsCat.SortOrder = request.SortOrder;
            newsCat.Alias = request.Alias;
            newsCat.Description = request.Description;
            newsCat.UpdatedAt = DateTime.Now;
            _context.tourCats.Update(newsCat);
            return await _context.SaveChangesAsync();
        }
    }
}
