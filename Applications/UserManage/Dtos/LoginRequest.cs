using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DongThucVatQuangTri.Applications.UserManage.Dtos
{
    public class LoginRequest
    {
        [Required(ErrorMessage = "Vui lòng điền tài khoản ")]
        public string Username { get; set; }
        [Required(ErrorMessage = "Vui lòng điền mật khẩu ")]
        public string Password { get; set; }
        public bool remember { get; set; }
    }
}
