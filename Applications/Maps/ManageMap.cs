using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.Maps.Dtos;
using DongThucVatQuangTri.Applications.NewsItem.Dtos.NewsDtos;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using DongThucVatQuangTri.Models.EF;
using DongThucVatQuangTri.Models.Entities;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;
using System.Net.Http.Headers;

namespace DongThucVatQuangTri.Applications.Maps
{
    public class ManageMap : IManageMap
    {
        private readonly DongThucVatContext _context;
        private readonly string _userContentFolder;
        private const string USER_CONTENT_FOLDER_NAME = "maps";
        public ManageMap(DongThucVatContext context, IWebHostEnvironment webHostEnvironment)
        {
            _context = context;
            _userContentFolder = Path.Combine(webHostEnvironment.WebRootPath, USER_CONTENT_FOLDER_NAME);
        }
        public async Task<long> CreateMap(CreateMapRequest request)
        {
            var checkExist = _context.map.Where(x => x.Name == request.Name && x.typeMap==request.typeMap.ToString()).FirstOrDefault();
            if (checkExist != null)
            {
                return -1;
            }
            var item = new Map()
            {
                Name = request.Name,
                Description = request.Description,
                CreateBy = request.CreateBy,
                CreatedAt = DateTime.Now,
                typeMap = request.typeMap.ToString(),
                linkMap = await SaveFile(request.linkMap)
            };
            _context.map.Add(item);
            await _context.SaveChangesAsync();
            return item.Id;
        }

        public async Task<int> deleteMap(int id)
        {
            var news = await _context.map.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (news == null)
                return -1;
            if (!String.IsNullOrEmpty(news.linkMap))
            {
                DeleteFile(news.linkMap);
            }
            _context.map.Remove(news);
            return await _context.SaveChangesAsync();
        }

        public async Task<List<MapViewModel>> getAll()
        {
            var data = await _context.map.Select(request => new MapViewModel()
            {
                Id = request.Id,
                Name = request.Name,
                Description = request.Description,
                UpdateBy = _context.appUsers.Where(x => x.Id.ToString() == request.UpdateBy).Select(x => x.FirstName).FirstOrDefault(),
                CreatedAt = request.CreatedAt,
                CreateBy = request.CreateBy,
                linkMap = request.linkMap,
                UpdatedAt = request.UpdatedAt,
                typeMap =Convert.ToInt32( request.typeMap)
            }).ToListAsync();
            return data;
        }

        public async Task<ApiResult<PageResult<MapViewModel>>> GetAlllPaging(GetMapPagingRequest request)
        {
            var query = from b in _context.map
                        where b.typeMap == request.typeMap.ToString()
                        select new { b };
            var list = query.ToList();
            if (!string.IsNullOrEmpty(request.Keyword))
            {
                query = query.Where(x => x.b.Name.Contains(request.Keyword));
            }
            
            int totalRow = await query.CountAsync();
            var data = await query.Skip((request.PageIndex - 1) * request.PageSize).Take(request.PageSize)
                .Select(request => new MapViewModel()
                {
                    Id = request.b.Id,
                    Name = request.b.Name,
                    Description = request.b.Description,
                    UpdateBy = _context.appUsers.Where(x => x.Id.ToString() == request.b.UpdateBy).Select(x => x.FirstName).FirstOrDefault(),
                    CreatedAt = request.b.CreatedAt,
                    NameCreate = _context.appUsers.Where(x => x.Id.ToString() == request.b.CreateBy).Select(x => x.FirstName).FirstOrDefault(),
                    linkMap = request.b.linkMap,
                    CreateBy = request.b.CreateBy,
                    UpdatedAt = request.b.UpdatedAt,
                    typeMap = Convert.ToInt32(request.b.typeMap),
                }).ToListAsync();
            var pageResult = new PageResult<MapViewModel>
            {
                TotalRecords = totalRow,
                Items = data,
                PageIndex = request.PageIndex,
                PageSize = request.PageSize,
            };
            return new ApiSuccessResult<PageResult<MapViewModel>>(pageResult);
        }

        public async Task<MapViewModel> getMapById(long id)
        {
            var query = from b in _context.map
                        where b.Id == id
                        select new { b };
            //var bannerCat = await _context.Banner.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (await query.CountAsync() == 0)
            {
                return null;
            }
            var NewsVm = await query.Select(request => new MapViewModel()
            {
                Id = request.b.Id,
                Name = request.b.Name,
                Description = request.b.Description,
                UpdateBy = _context.appUsers.Where(x => x.Id.ToString() == request.b.UpdateBy).Select(x => x.FirstName).FirstOrDefault(),
                CreatedAt = request.b.CreatedAt,
                NameCreate = _context.appUsers.Where(x => x.Id.ToString() == request.b.CreateBy).Select(x => x.FirstName).FirstOrDefault(),
                linkMap = request.b.linkMap,
                CreateBy = request.b.CreateBy,
                UpdatedAt = request.b.UpdatedAt,
                typeMap = Convert.ToInt32(request.b.typeMap),
            }).FirstOrDefaultAsync();
            return NewsVm;
        }

        public async Task<int> updateMap(UpdateMapRequest request)
        {
            var news = await _context.map.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
            if (news == null)
                return -1;

            if (request.linkMap != null)
            {
                if (!String.IsNullOrEmpty(news.linkMap))
                {
                    DeleteFile(news.linkMap);
                }
                news.linkMap = await SaveFile(request.linkMap);
            }
            news.Name = request.Name;
            news.Description = request.Description;
            news.UpdatedAt = DateTime.Now;
            news.typeMap = request.typeMap;
            _context.map.Update(news);
            return await _context.SaveChangesAsync();
        }
        public async Task DeleteFileAsync(string fileName)
        {
            var filePath = Path.Combine(_userContentFolder, fileName);
            if (File.Exists(filePath))
            {
                await Task.Run(() => File.Delete(filePath));
            }
        }

        public string GetFileUrl(string fileName)
        {
            return $"/{USER_CONTENT_FOLDER_NAME}/{fileName}";
        }

        public async Task SaveFileAsync(Stream mediaBinaryStream, string fileName)
        {
            var filePath = Path.Combine(_userContentFolder, fileName);
            using var output = new FileStream(filePath, FileMode.Create);
            await mediaBinaryStream.CopyToAsync(output);
        }
        public async Task<string> DeleteFile(string fileName)
        {
            await DeleteFileAsync(fileName);
            return fileName;
        }

        public async Task<string> SaveFile(IFormFile file)
        {
            var originalFileName = ContentDispositionHeaderValue.Parse(file.ContentDisposition).FileName.Trim('"');
            var fileName = $"{originalFileName.Split(".")[0]}_{Guid.NewGuid()}{Path.GetExtension(originalFileName)}";
            await SaveFileAsync(file.OpenReadStream(), fileName);
            return fileName;
        }
    }
}
