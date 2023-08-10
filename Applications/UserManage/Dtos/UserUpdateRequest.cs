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
        public string FirstName { get; set; }
        public string Phone { get; set; }
        public string Gender { get; set; }
        public DateTime? Dob { get; set; }
        public string Address { get; set; }
        public short Status { get; set; }
        public string Roles { get; set; }
    }
}
