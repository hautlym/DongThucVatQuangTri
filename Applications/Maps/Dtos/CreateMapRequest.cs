using System.ComponentModel.DataAnnotations;

namespace DongThucVatQuangTri.Applications.Maps.Dtos
{
    public class CreateMapRequest
    {
        [Required(ErrorMessage = "Vui lòng điền tên")]

        public string Name { get; set; }
        [Required(ErrorMessage = "Vui lòng điền mô tả")]

        public string Description { get; set; }
        public int? typeMap { get; set; }
        [Required(ErrorMessage = "Vui lòng chọn bản đồ")]

        public IFormFile linkMap { get; set; }
        public string? CreateBy { get; set; }
    }
}
