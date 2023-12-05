namespace DongThucVatQuangTri.Applications.Tours.Dtos
{
    public class CreateTourRequest
    {
        public string Name { get; set; }
        public string Alias { get; set; }
        public IFormFile Image { get; set; }
        public string ShortDescription { get; set; }
        public string Description { get; set; }
        public int? SortOrder { get; set; }
        public short? Status { get; set; }
        public string Author { get; set; }
        public string? Source { get; set; }
    }
}
