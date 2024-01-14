namespace DongThucVatQuangTri.Models.Entities
{
    public class introduce
    {
        public int id { get; set; }
        public string title { get; set; }
        public string content { get; set; }
        public string CreateBy { get; set; }
        public string UpdateBy { get; set; }
        public string typeNationPak{  get; set;}
        public DateTime? CreateAt { get; set; }
        public DateTime? UpdateAt { get; set; }
    }
}
