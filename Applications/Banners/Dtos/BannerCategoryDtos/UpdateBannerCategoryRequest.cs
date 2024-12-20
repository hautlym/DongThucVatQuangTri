using System.ComponentModel.DataAnnotations;

namespace DongThucVatQuangTri.Applications.Banners.Dtos.BannerCategoryDtos
{
    public class UpdateBannerCatRequest
    {
        public long Id { get; set; }
        [Required(ErrorMessage = "Vui lòng điền tên")]
        public string Name { get; set; }
        [Required(ErrorMessage = "Vui lòng chọn danh mục cha")]
        public int ParentId { get; set; }
        public string? Path { get; set; }
        public string? linkImg { get; set; }
        public bool isDelete { get; set; }

        [Required(ErrorMessage = "Vui lòng điền thứ tự")]
        public short Level { get; set; }
        public IFormFile? Image { get; set; }
        public short? Status { get; set; }

        [Required(ErrorMessage = "Vui lòng điền mô tả")]
        public string Description { get; set; }
        public int? SortOrder { get; set; }
        public string? Language { get; set; }
        public int? IdRelated { get; set; }
    }
}
