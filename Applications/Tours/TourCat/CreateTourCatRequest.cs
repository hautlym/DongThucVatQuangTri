namespace DongThucVatQuangTri.Applications.Tours.TourCat
{
    public class CreateTourCatRequest
    {
        public string Name { get; set; }
        public string Alias { get; set; }
        public IFormFile? Image { get; set; }
        public string? Description { get; set; }
        public int SortOrder { get; set; }
        public short Status { get; set; }
        public string? typeNationPark { get; set; }
        public string? CreateBy { get; set; }
    }
}
