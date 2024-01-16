using System.ComponentModel;
using System.Runtime.Serialization;

namespace DongThucVatQuangTri.Applications.Enums
{
    public static class Permittion
    {
        public static Dictionary<string, string> Roles = new Dictionary<string, string>
        {
            {"Menber" , "Phân quyền tài khoản" },
            {"NationParkMuongTe" , "BQL RPH Mường Tè" },
            {"NationParkNamGiang" , "BQL RPH Nam Giang" },
            {"Admin" , "Quản trị nội dung" },
            {"Administator" , "Quản trị website" },
        };
    }
}
