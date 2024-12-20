using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DongThucVatQuangTri.Applications.UserManage.Dtos
{
    public class RegisterRequest
    {
        [Required(ErrorMessage = "Vui lòng điền tên ")]
        public string FirstName { get; set; }
        [Required(ErrorMessage = "Vui lòng điền ngày sinh ")]
        public DateTime Dob { get; set; }
        [Required(ErrorMessage = "Vui lòng điền địa chỉ ")]
        public string Address { get; set; }
        [Required(ErrorMessage = "Vui lòng điền email ")]
        public string Email { get; set; }
        [Required(ErrorMessage = "Vui lòng điền số điện thoại ")]
        public string PhoneNumber { get; set; }
        [Required(ErrorMessage = "Vui lòng điền mật khẩu ")]
        public string Password { get; set; }
        [Required(ErrorMessage = "Vui lòng xác nhận mật khẩu ")]
        public string ConfirmPassword { get; set; }
        public string? Avatar { get; set; }
        [Required(ErrorMessage = "Vui lòng điền giới tính ")]
        public string Gender { get; set; }
        [Required(ErrorMessage = "Vui lòng chọn trạng thái ")]
        public short Status { get; set; }
        [Required(ErrorMessage = "Vui lòng chọn quyền ")]
        public string? Roles { get; set; }
        [Required(ErrorMessage = "Vui lòng chọn nhóm quyền ")]
        public int? GroupUserId { get; set; }
    }
}
