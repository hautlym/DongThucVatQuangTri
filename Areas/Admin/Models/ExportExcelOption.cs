namespace DongThucVatQuangTri.Areas.Admin.Models
{
    public class ExportExcelOption
    {
        public string typeNationPark { get; set; }
        public int TypeSpceies { get; set; }
        public DateTime? BeginDate { get; set; }
        public DateTime? ExpiredDate { get; set; }
        public string FileName { get; set;}
    }
}
