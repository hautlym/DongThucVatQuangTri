namespace DongThucVatQuangTri.Models.Entities
{
    public class tourCat
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string Alias { get; set; }
        public string Image { get; set; }
        public string Description { get; set; }
        public int SortOrder { get; set; }
        public DateTime? CreatedAt { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public string? CreateBy { get; set; }
        public string? UpdateBy { get; set; }
        public short Status { get; set; }
        public string? TypeNationPark { get; set; }
    }
}
