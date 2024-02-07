namespace DongThucVatQuangTri.Applications.Banners.Dtos.BannerDtos
{
    public class BannerViewModels
    {
        public long Id { get; set; }
        public string BannerCat { get; set; }
        public int BannerCatId { get; set; }
        public string Name { get; set; }
        public string Src { get; set; }
        public string SrcMobile { get; set; }
        public string Link { get; set; }
        public short? Width { get; set; }
        public short? Height { get; set; }
        public short? Type { get; set; }
        public short? Status { get; set; }
        public string Multitext { get; set; }
        public string Description { get; set; }
        public int? SortOrder { get; set; }
        public DateTime? CreatedAt { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public string Language { get; set; }
        public int? IdRelated { get; set; }
        public string? typeNationPark { get; set; }
    }
}
