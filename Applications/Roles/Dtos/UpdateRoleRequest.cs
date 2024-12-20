using System.ComponentModel.DataAnnotations;

namespace DongThucVatQuangTri.Applications.Roles.Dtos
{
    public class UpdateRoleRequest
    {
        public int Id { get; set; }
        [Required(ErrorMessage ="Vui lòng điền tên quyền")]
        public string RoleName { get; set; }
      
    }
}
