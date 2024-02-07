namespace DongThucVatQuangTri.Applications.Maps.Dtos
{
    public class MapViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string linkMap { get; set; }
        public int? typeMap { get; set; }
        public DateTime? CreatedAt { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public string? CreateBy { get; set; }
        public string? UpdateBy { get; set; }
        public string? NameCreate { get; set;}
    }
}
