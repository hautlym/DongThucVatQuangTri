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
        public string NewPassword { get; set; }
        [Compare("NewPassword", ErrorMessage = "Nhập khẩu mật lại không chính xác")]
        public string? ConfirmPassword { get; set; }
        public string code { get; set; }
        public string UserId { get; set; }
        public string? Email { get; set; }
    }
}
