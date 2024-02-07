using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.Common.FileStorageEdit;
using DongThucVatQuangTri.Applications.ConservationAreas.Dtos;
using DongThucVatQuangTri.Applications.EcotourismSafeties.Dtos;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using DongThucVatQuangTri.Models.EF;
using DongThucVatQuangTri.Models.Entities;
using Microsoft.EntityFrameworkCore;
using System.Net.Http.Headers;

namespace DongThucVatQuangTri.Applications.ConservationAreas
{
    public class ManageConservationArea : IManageConservationArea
    {
        private readonly DongThucVatContext _context;
        private readonly IStorageServiceEdit _manageFile;
        public ManageConservationArea(DongThucVatContext context, IStorageServiceEdit manageFile)
        {
            _context = context;
            _manageFile = manageFile;

        }
        public async Task<string> SaveFile(IFormFile file)
        {
            var originalFileName = ContentDispositionHeaderValue.Parse(file.ContentDisposition).FileName.Trim('"');
            var fileName = $"{Guid.NewGuid()}{Path.GetExtension(originalFileName)}";
            await _manageFile.SaveFileAsync(file.OpenReadStream(), "ConservationArea", fileName);
            return fileName;
        }
        public async Task<long> Create(CreateConservationAreaRequest request)
        {
            var check =await _context.conservationAreas.Where(x => x.NameConservation == request.NameConservation).FirstOrDefaultAsync();
            if(check != null)
            {
                return -1;
            }
            var item = new ConservationArea()
            {
                Image = request.Image != null ? await SaveFile(request.Image) : "",
                Description = request.Description,
                CreateAt = DateTime.Now,
                Address = request.Address,
                Email = request.Email,
                Phone= request.Phone,
                UpdateAt = DateTime.Now,
                NameConservation = request.NameConservation,
            };
            _context.conservationAreas.Add(item);
            await _context.SaveChangesAsync();
            return item.Id;
        }

        public async Task<int> delete(int id)
        {
            var news = await _context.conservationAreas.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (news == null)
                return -1;
            if (!string.IsNullOrEmpty(news.Image))
            {
                await _manageFile.DeleteFileAsync("ConservationArea", news.Image);
            }
            _context.conservationAreas.Remove(news);
            return await _context.SaveChangesAsync();
        }

        public Task<List<ConservationAreaViewModel>> getAll()
        {
            throw new NotImplementedException();
        }

        public async Task<ApiResult<PageResult<ConservationAreaViewModel>>> GetAlllPaging(getConservationPagingRequest request)
        {
            var query = from b in _context.conservationAreas
                        select new { b };
            var list = query.ToList();
            if (!string.IsNullOrEmpty(request.Keyword))
            {
                query = query.Where(x => x.b.NameConservation.Contains(request.Keyword));
            }
           
            int totalRow = await query.CountAsync();
            var data = await query.Skip((request.PageIndex - 1) * request.PageSize).Take(request.PageSize)
                .Select(request => new ConservationAreaViewModel()
                {
                    Id = request.b.Id,
                    Image = request.b.Image,
                    Description = request.b.Description,
                    CreateAt = request.b.CreateAt,
                    UpdateAt = request.b.UpdateAt,
                    NameConservation = request.b.NameConservation,
                    Address= request.b.Address,
                    Email= request.b.Email,
                    Phone= request.b.Phone,
                }).ToListAsync();
            var pageResult = new PageResult<ConservationAreaViewModel>
            {
                TotalRecords = totalRow,
                Items = data,
                PageIndex = request.PageIndex,
                PageSize = request.PageSize,
            };
            return new ApiSuccessResult<PageResult<ConservationAreaViewModel>>(pageResult);
        }

        public async Task<ConservationAreaViewModel> getById(long id)
        {
            var query = from b in _context.conservationAreas
                        where b.Id == id
                        select new { b };
            //var bannerCat = await _context.Banner.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (await query.CountAsync() == 0)
            {
                return null;
            }
            var NewsVm = await query.Select(request => new ConservationAreaViewModel()
            {
                Id = request.b.Id,
                Image = request.b.Image,
                Description = request.b.Description,
                CreateAt = request.b.CreateAt,
                UpdateAt = request.b.UpdateAt,
                NameConservation = request.b.NameConservation,
                Address = request.b.Address,
                Email = request.b.Email,
                Phone = request.b.Phone,
            }).FirstOrDefaultAsync();
            return NewsVm;
        }

        public async Task<int> update(UpdateConservationAreaRequest request)
        {
            var news = await _context.conservationAreas.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
            if (news == null)
                return -1;

            if (request.IsDelete == true)
            {
                if (!string.IsNullOrEmpty(news.Image))
                {
                    await _manageFile.DeleteFileAsync("ConservationArea", news.Image);
                }
                news.Image = "";
            }
            if (request.Image != null)
            {
                if (!string.IsNullOrEmpty(news.Image))
                {
                    await _manageFile.DeleteFileAsync("ConservationArea", news.Image);
                }
                news.Image = await this.SaveFile(request.Image);
            }
            news.NameConservation = request.NameConservation;
            news.Description = request.Description;
            news.UpdateAt = DateTime.Now;
            news.Address = request.Address;
            news.Email = request.Email;
            news.Phone = request.Phone;
            _context.conservationAreas.Update(news);
            return await _context.SaveChangesAsync();
        }
    }
}
