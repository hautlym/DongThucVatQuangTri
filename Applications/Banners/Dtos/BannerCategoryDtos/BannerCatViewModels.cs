namespace DongThucVatQuangTri.Applications.Banners.Dtos.BannerCategoryDtos
{
    public class BannerCatViewModels
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public int ParentId { get; set; }
        public string Path { get; set; }
        public short Level { get; set; }
        public string Image { get; set; }
        public short? Status { get; set; }
        public string Description { get; set; }
        public int? SortOrder { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }
        public string Language { get; set; }
        public int? IdRelated { get; set; }
        public string? Parentname { get; set; }
    }
}
