namespace DongThucVatQuangTri.Applications.Banners.Dtos.BannerCategoryDtos
{
    public class UpdateBannerCatRequest
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public int ParentId { get; set; }
        public string? Path { get; set; }
        public string? linkImg { get; set; }
        public bool isDelete { get; set; }
        public short Level { get; set; }
        public IFormFile? Image { get; set; }
        public short? Status { get; set; }
        public string Description { get; set; }
        public int? SortOrder { get; set; }
        public string? Language { get; set; }
        public int? IdRelated { get; set; }
    }
}
