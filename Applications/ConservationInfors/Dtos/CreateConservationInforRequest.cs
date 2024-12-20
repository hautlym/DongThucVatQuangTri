using System.ComponentModel.DataAnnotations;

namespace DongThucVatQuangTri.Applications.ConservationInfors.Dtos
{
    public class CreateConservationInforRequest
    {

        [Required(ErrorMessage = "Vui lòng điền tên")]
        public string Name { get; set; }

        [Required(ErrorMessage = "Vui lòng điền alias")]
        public string Alias { get; set; }

        [Required(ErrorMessage = "Vui lòng chọn ảnh")]
        public IFormFile Image { get; set; }

        [Required(ErrorMessage = "Vui lòng điền giới thiệu")]
        public string ShortDescription { get; set; }

        [Required(ErrorMessage = "Vui lòng điền nội dung")]
        public string Description { get; set; }
        public int? SortOrder { get; set; }
        public short? Status { get; set; }
        public string Author { get; set; }
        public string? Source { get; set; }
        public string? typeNationPark { get; set; }
    }
}
