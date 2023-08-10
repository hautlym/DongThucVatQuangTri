using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.News.Dtos.NewsCatDtos;
using DongThucVatQuangTri.Applications.UserManage.Dtos;

namespace DongThucVatQuangTri.Applications.News.NewsCatManage
{
    public interface IManageNewsCat
    {
        Task<List<NewsCatViewModels>> GetAll();
        public Task<NewsCatViewModels> getNewsCatById(int id);
        Task<long> CreateNewsCat(CreateNewsCatRequest request);
        public Task<ApiResult<PageResult<NewsCatViewModels>>> GetAlllPaging(GetNewsCatPagingRequest request);
        Task<int> deleteNewsCat(int id);
        public Task<int> updateNewsCat(UpdateNewsCatRequest request);
        public Task<int> ChangeStatus(ChangeStatusRequest request);
    }
}
