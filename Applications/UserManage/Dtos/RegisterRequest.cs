using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DongThucVatQuangTri.Applications.UserManage.Dtos
{
    public class RegisterRequest
    {
        public string FirstName { get; set; }
        public DateTime Dob { get; set; }
        public string Address { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
        public string Password { get; set; }
        public string ConfirmPassword { get; set; }
        public string? Avatar { get; set; }
        public string Gender { get; set; }
        public short Status { get; set; }
        public string? Roles { get; set; }
    }
}
