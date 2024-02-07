namespace DongThucVatQuangTri.Applications.Tours.TourCat
{
    public class UpdateTourCatRequest
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string Alias { get; set; }
        public string? linkUrl { get; set; }
        public bool isDelete { get; set; }
        public IFormFile? Image { get; set; }
        public string? Description { get; set; }
        public int SortOrder { get; set; }
        public short Status { get; set; }
        public string? typeNationPark { get; set; }
        public string? UpdateBy { get; set; }
    }
}
