using System.ComponentModel.DataAnnotations;

namespace DongThucVatQuangTri.Applications.UserManage.Dtos
{
    public class UpdatePasswordRequest
    {
        public Guid Id { get; set; }
        [Required(ErrorMessage = "Vui lòng điền mật khẩu hiện tại ")]
        public string CurrentPassword { get; set; }
        [Required(ErrorMessage = "Vui lòng điền mật khẩu mới")]
        public string NewPassword { get; set; }
        [Required(ErrorMessage = "Vui lòng xác nhận mật khẩu ")]
        public string ConfirmPassword { get; set; }
    }
}
