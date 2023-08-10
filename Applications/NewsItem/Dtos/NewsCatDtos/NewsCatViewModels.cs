namespace DongThucVatQuangTri.Applications.News.Dtos.NewsCatDtos
{
    public class NewsCatViewModels
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string Alias { get; set; }
        public int ParentId { get; set; }
        public string? ParentName { get; set; }
        public DateTime UpdateAt { get; set; }
        public DateTime CreateAt { get; set; }
        public string? Image { get; set; }
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
