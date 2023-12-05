using System.ComponentModel;
using System.Runtime.Serialization;

namespace DongThucVatQuangTri.Applications.Enums
{
    public static class Permittion
    {
        public static Dictionary<string, string> Roles = new Dictionary<string, string>
        {
            {"Menber" , "Phân quyền tài khoản" },
            {"NationParkMuongTe" , "Vườn quốc gia Mường Tè" },
            {"NationParkNamGiang" , "Vườn quốc gia Nam Giang" },
            {"Admin" , "Quản trị nội dung" },
            {"Administator" , "Quản trị website" },
        };
    }
}
