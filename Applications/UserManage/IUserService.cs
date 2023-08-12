
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DongThucVatQuangTri.Applications.UserManage
{
    public interface IUserService
    {
        Task<ApiResult<string>> Authencate(LoginRequest request);
        Task<ApiResult<bool>> Register(RegisterRequest request);
        Task<ApiResult<bool>> Update(Guid id, UserUpdateRequest request);

        Task<ApiResult<PageResult<UserViewModels>>> GetUserPaging(GetUserPagingRequest request);
        Task<ApiResult<bool>> delete(Guid id);
        Task<ApiResult<UserViewModels>> GetById(Guid id);
        Task<ApiResult<bool>> ChangePassword(Guid id,UpdatePasswordRequest request);
        Task<ApiResult<bool>> AdminChangePassword(Guid id, AdminUpdatePasswordRequest request);
        Task<ApiResult<bool>> CheckSignedTime(Guid id);
    }
}
