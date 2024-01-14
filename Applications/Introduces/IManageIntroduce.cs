using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.Introduces.Dtos;
using DongThucVatQuangTri.Applications.Roles.Dtos;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using DongThucVatQuangTri.Models.Entities;

namespace DongThucVatQuangTri.Applications.Introduces
{
    public interface IManageIntroduce
    {
        public Task<List<IntroduceViewModel>> getAll();
        public Task<int> Update(UpdateIntroduceRequest request);
        public Task<IntroduceViewModel> getById(int Id);
    }
}
