namespace DongThucVatQuangTri.Applications.ConservationInfors.Dtos
{
    public class ConservationInforViewModel
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string Alias { get; set; }
        public string Image { get; set; }
        public string ShortDescription { get; set; }
        public string Description { get; set; }
        public int? TotalView { get; set; }
        public int? SortOrder { get; set; }
        public DateTime? CreatedAt { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public short? Status { get; set; }
        public string Author { get; set; }
        public string Source { get; set; }
        public string? typeNationPark { get; set; }
        public string? NameCreate { get; set; }
    }
}
