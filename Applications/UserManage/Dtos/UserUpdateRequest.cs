using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DongThucVatQuangTri.Applications.UserManage.Dtos
{
    public class UserUpdateRequest
    {
        public Guid Id { get; set; }
        [Required(ErrorMessage = "Vui lòng điền tên ")]
        public string FirstName { get; set; }
        [Required(ErrorMessage = "Vui lòng điền số điện thoại ")]
        public string Phone { get; set; }
        [Required(ErrorMessage = "Vui lòng chọn giới tính ")]
        public string Gender { get; set; }
        public DateTime? Dob { get; set; }
        [Required(ErrorMessage = "Vui lòng điền địa chỉ ")]
        public string Address { get; set; }
        [Required(ErrorMessage = "Vui lòng điền trạng thái ")]
        public short Status { get; set; }
        [Required(ErrorMessage = "Vui lòng chọn quyền ")]
        public string Roles { get; set; }
        [Required(ErrorMessage = "Vui lòng chọn nhóm người dùng ")]
        public int? GroupUserId { get; set; }
    }
}
