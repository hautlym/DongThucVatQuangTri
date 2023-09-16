using System.ComponentModel;
using System.Runtime.Serialization;

namespace DongThucVatQuangTri.Applications.Enums
{
    public static class Permittion
    {
        public static Dictionary<string, string> Roles = new Dictionary<string, string>
        {
            {"Menber" , "Phân quyền tài khoản" },
            {"NationPark" , "Vườn quốc gia" },
            {"Admin" , "Quản trị nội dung" },
            {"Administator" , "Quản trị website" },
        };
    }
}
