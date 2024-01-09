using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.NewsItem.Dtos.NewsDtos;

namespace DongThucVatQuangTri.Applications.NewsItem.NewsManage
{
    public interface IManageNews
    {
        public Task<List<NewsViewModels>> getAll();
        public Task<NewsViewModels> getNewsById(long id);
        Task<long> CreateNews(CreateNewsRequest request);
        public Task<ApiResult<PageResult<NewsViewModels>>> GetAlllPaging(GetNewsPagingRequest request);
        public Task<ApiResult<PageResult<NewsViewModels>>> PublicNewsPaging(GetNewsPagingRequest request);
        Task<int> deleteNews(int id);
        public Task<int> updateNews(UpdateNewsRequest request);
        public Task<int> ChangeStatus(ChangeStatusRequest request);
        public Task<int> ChangeIsHot(ChangeIsHotRequest request);
        public Task<int> IncreaseView(int id);
    }
}
