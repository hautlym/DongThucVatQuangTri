namespace DongThucVatQuangTri.Applications.Tours.TourCat
{
    public class TourCatViewModel
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string Alias { get; set; }
        public DateTime? UpdateAt { get; set; }
        public DateTime? CreateAt { get; set; }
        public string? Image { get; set; }
        public string? Description { get; set; }
        public int SortOrder { get; set; }
        public short Status { get; set; }
        public string? typeNationPark { get; set; }
    }
}
