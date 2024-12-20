using System.ComponentModel.DataAnnotations;

namespace DongThucVatQuangTri.Applications.NewsItem.Dtos.NewsCatDtos
{
    public class CreateNewsCatRequest
    {
        [Required(ErrorMessage = "Vui lòng điền tên ")]

        public string Name { get; set; }
        [Required(ErrorMessage = "Vui lòng điền alias")]

        public string Alias { get; set; }
        [Required(ErrorMessage = "Vui lòng chọn danh mục")]

        public int ParentId { get; set; }
        public IFormFile? Image { get; set; }
        public string? Description { get; set; }
        [Required(ErrorMessage = "Vui lòng điền thứ tự")]

        public int SortOrder { get; set; }
        public short Status { get; set; }
        public string? Language { get; set; }
        public string? TitleSeo { get; set; }
        public string? ContentSeo { get; set; }
        public string? KeySeo { get; set; }
        public int? IdRelated { get; set; }
    }
}
