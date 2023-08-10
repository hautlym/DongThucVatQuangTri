namespace DongThucVatQuangTri.Applications.News.Dtos.NewsCatDtos
{
    public class CreateNewsCatRequest
    {
        public string Name { get; set; }
        public string Alias { get; set; }
        public int ParentId { get; set; }
        public IFormFile? Image { get; set; }
        public string? Description { get; set; }
        public int SortOrder { get; set; }
        public short Status { get; set; }
        public string? Language { get; set; }
        public string? TitleSeo { get; set; }
        public string? ContentSeo { get; set; }
        public string? KeySeo { get; set; }
        public int? IdRelated { get; set; }
    }
}
