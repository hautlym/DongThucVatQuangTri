using System.ComponentModel.DataAnnotations;

namespace DongThucVatQuangTri.Applications.Banners.Dtos.BannerCategoryDtos
{
    public class CreateBannerCatRequest
    {
        [Required(ErrorMessage = "Vui lòng điền tên")]
        public string Name { get; set; }
        [Required(ErrorMessage = "Vui lòng chọn danh mục cha")]
        public int ParentId { get; set; }
        public string? Path { get; set; }

        [Required(ErrorMessage = "Vui lòng điền thứ tự")]
        public short Level { get; set; }
        public IFormFile? Image { get; set; }
        public short? Status { get; set; }
        public string? Description { get; set; }
        public int? SortOrder { get; set; }
        public string? Language { get; set; }
        public int? IdRelated { get; set; }
    }
}
