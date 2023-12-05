namespace DongThucVatQuangTri.Models.Entities
{
    public class Map
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string linkMap { get; set; }
        public DateTime? CreatedAt { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public string? CreateBy { get; set; }
        public string? UpdateBy { get; set;}
    }
}
