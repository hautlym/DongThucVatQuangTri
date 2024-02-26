using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.GroupUsers.Dtos;
using DongThucVatQuangTri.Applications.Maps.Dtos;
using DongThucVatQuangTri.Applications.Roles.Dtos;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using DongThucVatQuangTri.Models.EF;
using DongThucVatQuangTri.Models.Entities;
using Microsoft.EntityFrameworkCore;

namespace DongThucVatQuangTri.Applications.GroupUsers
{
    public class ManageGroupUser : IManageGroupUser
    {
        private readonly DongThucVatContext _context;
        public ManageGroupUser(DongThucVatContext context)
        {
            _context = context;
        }
        public async Task<long> Create(CreateGroupUserRequest request)
        {
            var checkExist =await _context.groupUsers.Where(x=>x.Name==request.Name).FirstOrDefaultAsync();
            if (checkExist != null)
            {
                return -1;
            }
            var item = new GroupUser()
            {
                Name = request.Name,
               UpdateAt = DateTime.Now,
            };
            _context.groupUsers.Add(item);
            await _context.SaveChangesAsync();
            return item.Id;
        }

        public async Task<int> delete(int id)
        {
            var news = await _context.groupUsers.Where(x => x.Id == id).FirstOrDefaultAsync();
            if (news == null)
                return -1;
            _context.groupUsers.Remove(news);
            return await _context.SaveChangesAsync();
        }

        public async Task<List<GroupUserViewModel>> getAll()
        {
            var data = await _context.groupUsers.Select(request => new GroupUserViewModel()
            {
                Id = request.Id,
                Name = request.Name,
                UpdateAt= DateTime.Now,
            }).ToListAsync();
            return data;
        }

        public async Task<ApiResult<PageResult<GroupUserViewModel>>> GetAlllPaging(getGroupUserPaging request)
        {
            var query = from r in _context.groupUsers
                        select r;
            var list = query.ToList();
            if (!string.IsNullOrEmpty(request.Keyword))
            {
                query = query.Where(x => x.Name.Contains(request.Keyword));
            }
            int totalRow = await query.CountAsync();
            var data = await query.Skip((request.PageIndex - 1) * request.PageSize).Take(request.PageSize)
                .Select(x => new GroupUserViewModel()
                {
                    Id = x.Id,
                    Name = x.Name,
                    UpdateAt = x.UpdateAt,
                    totalAccount = _context.appUsers.Where(y => y.GroupUserId == x.Id).Count(),
                })
                .ToListAsync();
            var pageResult = new PageResult<GroupUserViewModel>
            {
                TotalRecords = totalRow,
                Items = data,
                PageIndex = request.PageIndex,
                PageSize = request.PageSize,
            };
            return new ApiSuccessResult<PageResult<GroupUserViewModel>>(pageResult);
        }

        public async Task<GroupUserViewModel> getById(long id)
        {
            var role = await _context.groupUsers.Where(x => x.Id == id).Select(x=>new GroupUserViewModel
            {
                Id = x.Id,
                Name=x.Name,
                UpdateAt = x.UpdateAt
            }).FirstOrDefaultAsync();
            return role;
        }

        public async Task<int> update(UpdateGroupUserRequest request)
        {
            try
            {
                var checkexist = _context.groupUsers.Where(x => x.Name == request.Name).FirstOrDefault();
                if (checkexist != null)
                {
                    return -2;
                }
                var role = await _context.groupUsers.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
                if (role == null)
                    return -1;
                role.Name = request.Name;
                role.UpdateAt = DateTime.Now;
                _context.groupUsers.Update(role);
                return _context.SaveChanges();
            }
            catch (Exception ex)
            {
                return -1;
            }
        }
    }
}
