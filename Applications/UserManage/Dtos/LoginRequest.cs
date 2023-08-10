using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DongThucVatQuangTri.Applications.UserManage.Dtos
{
    public class LoginRequest
    {
        public string Username { get; set; }
        public string Password { get; set; }
        public bool remember { get; set; }
    }
}
