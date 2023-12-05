namespace DongThucVatQuangTri.Applications.Tours.Dtos
{
    public class UpdateTourRequest
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string Alias { get; set; }
        public IFormFile? Image { get; set; }
        public bool IsDelete { get; set; }
        public string? linkUrl { get; set; }
        public string ShortDescription { get; set; }
        public string Description { get; set; }
        public int? TotalView { get; set; }
        public int? SortOrder { get; set; }
        public short? Status { get; set; }
        public string? Source { get; set; }

    }
}
