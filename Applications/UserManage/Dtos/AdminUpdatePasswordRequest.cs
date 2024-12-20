using System.ComponentModel.DataAnnotations;

namespace DongThucVatQuangTri.Applications.UserManage.Dtos
{
    public class AdminUpdatePasswordRequest
    {
        public Guid Id { get; set; }
        [Required(ErrorMessage = "Vui lòng điền mật khẩu ")]
        public string NewPassword { get; set; }
        [Required(ErrorMessage = "Vui lòng xác nhận mật khẩu ")]
        public string ConfirmPassword { get; set; }
    }
}
