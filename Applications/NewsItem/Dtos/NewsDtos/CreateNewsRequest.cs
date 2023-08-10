namespace DongThucVatQuangTri.Applications.NewsItem.Dtos.NewsDtos
{
    public class CreateNewsRequest
    {
        public int? RootNewsCatId { get; set; }
        public int? NewsCatId { get; set; }
        public string Name { get; set; }
        public string Alias { get; set; }
        public IFormFile? Image { get; set; }
        public string? ShortDescription { get; set; }
        public string? Description { get; set; }
        public int? SortOrder { get; set; }
        public short? IsHot { get; set; }
        public short? IsSystem { get; set; }
        public short? Status { get; set; }
        public string? Author { get; set; }
        public string? Source { get; set; }
        public DateTime? PostAt { get; set; }
        public string? TitleSeo { get; set; }
        public string? ContentSeo { get; set; }
        public string? KeySeo { get; set; }
        public string? Language { get; set; }
        public int? IdRelated { get; set; }
    }
}
