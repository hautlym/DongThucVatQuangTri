namespace DongThucVatQuangTri.Applications.Banners.Dtos.BannerDtos
{
    public class UpdateBannerRequest
    {
        public long Id { get; set; }
        public int BannerCatId { get; set; }
        public string Name { get; set; }
        public IFormFile? Src { get; set; }
        public IFormFile? SrcMobile { get; set; }
        public string? linkUrl { get; set; }
        public string? linkUrlMobile { get; set; }
        public bool isDelete { get; set; }
        public bool isDeleteMobile { get; set; }
        public string? Link { get; set; }
        public short? Width { get; set; }
        public short? Height { get; set; }
        public short? Type { get; set; }
        public short? Status { get; set; }
        public string? Multitext { get; set; }
        public string? Description { get; set; }
        public int? SortOrder { get; set; }
        public string? Language { get; set; }
        public int? IdRelated { get; set; }
        public string? typeNationPark { get; set; }
    }
}
