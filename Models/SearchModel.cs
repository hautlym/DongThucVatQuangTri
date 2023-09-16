using DongThucVatQuangTri.Applications.Common;

namespace DongThucVatQuangTri.Models
{
    public class SearchModel
    {
        public string? keyword { get; set; }
        public string? keyword2 { get; set; }
        public int IdLoai { get; set; }
        public int id_nganh { get; set; }
        public int id_lop { get; set; }
        public int id_bo { get; set; } 
        public int id_ho { get; set; } 
        public int icun { get; set; } 
        public int sdvn { get; set; } 
        public int ndcp { get; set; } 
        public int nd64cp { get; set; } 
    }
}
