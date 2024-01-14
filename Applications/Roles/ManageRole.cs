using DongThucVatQuangTri.Applications.Banners.Dtos.BannerDtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.Roles.Dtos;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using DongThucVatQuangTri.Models.EF;
using DongThucVatQuangTri.Models.Entities;
using Microsoft.EntityFrameworkCore;

namespace DongThucVatQuangTri.Applications.Roles
{
    public class ManageRole : IManageRole
    {
        private readonly DongThucVatContext _context;
        public ManageRole(DongThucVatContext context)
        {
            _context = context;
        }

        public async Task<List<Role>> getAll()
        {
            var data =await _context.Role.ToListAsync();
            return data;
        }

        public async Task<Role> getRoleById(int Id)
        {
            var role = await _context.Role.Where(x => x.Id == Id).FirstOrDefaultAsync();
            return role;
        }

        public async Task<ApiResult<PageResult<RoleViewModels>>> getRolePaging(getRolePaging request)
        {
            var query = from r in _context.Role
                        select r;
            var list = query.ToList();
            if (!string.IsNullOrEmpty(request.Keyword))
            {
                query = query.Where(x => x.Name.Contains(request.Keyword));
            }
            int totalRow = await query.CountAsync();
            var data = await query.Skip((request.PageIndex - 1) * request.PageSize).Take(request.PageSize)
                .Select(x => new RoleViewModels() {
                    Id = x.Id,
                    Name = x.Name,
                    UpdateAt = x.UpdateAt,
                    totalAccount = _context.appUsers.Where(y=>y.Roles==x.Value).Count(),
                })
                .ToListAsync();
            var pageResult = new PageResult<RoleViewModels>
            {
                TotalRecords = totalRow,
                Items = data,
                PageIndex = request.PageIndex,
                PageSize = request.PageSize,
            };
            return new ApiSuccessResult<PageResult<RoleViewModels>>(pageResult);
        }
       
        
        public async Task<int> UpdateRole(UpdateRoleRequest request)
        {
            try
            {
                var checkexist = _context.Role.Where(x => x.Name == request.RoleName).FirstOrDefault();
                if(checkexist != null)
                {
                    return -2;
                }
                var role = await _context.Role.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
                if (role == null)
                    return -1;
                role.Name = request.RoleName;
                role.UpdateAt = DateTime.Now;
                _context.Role.Update(role);
                return _context.SaveChanges();
            }catch (Exception ex)
            {
                return -1;
            }

        }
    }
}
