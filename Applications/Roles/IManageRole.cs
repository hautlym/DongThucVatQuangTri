
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.Roles.Dtos;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using DongThucVatQuangTri.Models.Entities;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace DongThucVatQuangTri.Applications.Roles
{
    public interface IManageRole
    {
        public Task<List<Role>> getAll();
        public Task<int> UpdateRole(UpdateRoleRequest request);
        public Task<ApiResult<PageResult<RoleViewModels>>> getRolePaging(getRolePaging request);
        public Task<Role> getRoleById(int Id);
    }
}
