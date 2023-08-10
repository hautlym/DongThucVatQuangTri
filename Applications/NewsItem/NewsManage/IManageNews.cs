using DongThucVatQuangTri.Applications.News.Dtos.NewsDtos;
using DongThucVatQuangTri.Applications.News.Dtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using DongThucVatQuangTri.Applications.Banners.Dtos;

namespace DongThucVatQuangTri.Applications.News.NewsManage
{
    public interface IManageNews
    {
        public Task<NewsViewModels> getNewsById(long id);
        Task<long> CreateNews(CreateNewsRequest request);
        public Task<ApiResult<PageResult<NewsViewModels>>> GetAlllPaging(GetNewsPagingRequest request);
        Task<int> deleteNews(int id);
        public Task<int> updateNews(UpdateNewsRequest request);
        public Task<int> ChangeStatus(ChangeStatusRequest request);
        public Task<int> ChangeIsHot(ChangeIsHotRequest request);
    }
}
