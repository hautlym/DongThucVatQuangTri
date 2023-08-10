using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.News.Dtos.NewsDtos;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using DongThucVatQuangTri.Models.EF;
using DongThucVatQuangTri.Models.Entities;

namespace DongThucVatQuangTri.Applications.News.NewsManage
{
    public class ManageNews:IManageNews
    {
        private readonly DongThucVatContext _context;
        private readonly IManageFile _manageFile;
        public ManageNews(DongThucVatContext context, IManageFile manageFile)
        {
            _context = context;
            _manageFile = manageFile;

        }

        public Task<int> ChangeIsHot(ChangeIsHotRequest request)
        {
            throw new NotImplementedException();
        }

        public Task<int> ChangeStatus(ChangeStatusRequest request)
        {
            throw new NotImplementedException();
        }

        public async Task<long> CreateNews(CreateNewsRequest request)
        {
            var item = new News()
            {

            };
            _context.Banner.Add(item);
            await _context.SaveChangesAsync();
            return item.Id;
        }

        public Task<int> deleteNews(int id)
        {
            throw new NotImplementedException();
        }

        public Task<ApiResult<PageResult<NewsViewModels>>> GetAlllPaging(GetNewsPagingRequest request)
        {
            throw new NotImplementedException();
        }

        public Task<NewsViewModels> getNewsById(long id)
        {
            throw new NotImplementedException();
        }

        public Task<int> updateNews(UpdateNewsRequest request)
        {
            throw new NotImplementedException();
        }
    }
}
