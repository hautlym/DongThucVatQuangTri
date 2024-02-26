using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.GroupUsers.Dtos;
using DongThucVatQuangTri.Applications.Maps.Dtos;
using DongThucVatQuangTri.Applications.UserManage.Dtos;

namespace DongThucVatQuangTri.Applications.GroupUsers
{
    public interface IManageGroupUser
    {
        public Task<List<GroupUserViewModel>> getAll();
        public Task<GroupUserViewModel> getById(long id);
        Task<long> Create(CreateGroupUserRequest request);
        public Task<ApiResult<PageResult<GroupUserViewModel>>> GetAlllPaging(getGroupUserPaging request);
        Task<int> delete(int id);
        public Task<int> update(UpdateGroupUserRequest request);
    }
}
