using System.ComponentModel.DataAnnotations;

namespace DongThucVatQuangTri.Applications.Maps.Dtos
{
    public class UpdateMapRequest
    {
        public int Id { get; set; }
        [Required(ErrorMessage = "Vui lòng điền tên")]

        public string Name { get; set; }
        [Required(ErrorMessage = "Vui lòng điền mô tả")]

        public string Description { get; set; }
        public string Url { get; set; }
        public IFormFile? linkMap { get; set; }
        public string? UpdateBy { get; set; }
        public string? typeMap { get; set; }
    }
}
