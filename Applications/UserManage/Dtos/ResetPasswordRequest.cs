using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DongThucVatQuangTri.Applications.UserManage.Dtos
{
    public class ResetPasswordRequest
    {
        [Required(ErrorMessage = "Vui lòng điền mật khẩu ")]
        public string NewPassword { get; set; }
        [Compare("NewPassword", ErrorMessage = "Xác thực mật khẩu không chính xác")]
        public string? ConfirmPassword { get; set; }
        public string code { get; set; }
        public string UserId { get; set; }
        public string? Email { get; set; }
    }
}
