using System.ComponentModel.DataAnnotations;

namespace DongThucVatQuangTri.Applications.EcotourismSafeties.Dtos
{
    public class UpdateEcotourismSafetyRequest
    {
        public long Id { get; set; }
        [Required(ErrorMessage = "Vui lòng điền tên")]

        public string Name { get; set; }
        [Required(ErrorMessage = "Vui lòng điền alias")]

        public string Alias { get; set; }
        public IFormFile? Image { get; set; }
        public bool IsDelete { get; set; }
        public string? linkUrl { get; set; }
        [Required(ErrorMessage = "Vui lòng điền giới thiệu")]

        public string ShortDescription { get; set; }
        [Required(ErrorMessage = "Vui lòng điền nội dung")]

        public string Description { get; set; }
        public int? TotalView { get; set; }
        public int? SortOrder { get; set; }
        public short? Status { get; set; }
        public string? Source { get; set; }
        public string? typeNationPark { get; set; }
    }
}
