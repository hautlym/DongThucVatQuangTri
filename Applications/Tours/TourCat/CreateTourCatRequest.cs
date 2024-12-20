using System.ComponentModel.DataAnnotations;

namespace DongThucVatQuangTri.Applications.Tours.TourCat
{
    public class CreateTourCatRequest
    {
        [Required(ErrorMessage = "Vui lòng điền tên ")]

        public string Name { get; set; }
        [Required(ErrorMessage = "Vui lòng điền alias ")]

        public string Alias { get; set; }
        [Required(ErrorMessage = "Vui lòng chọn ảnh ")]

        public IFormFile? Image { get; set; }
        [Required(ErrorMessage = "Vui lòng điền giới thiệu ")]

        public string? Description { get; set; }
        [Required(ErrorMessage = "Vui lòng điền thứ tự ")]

        public int SortOrder { get; set; }
        public short Status { get; set; }
        public string? typeNationPark { get; set; }
        public string? CreateBy { get; set; }
    }
}
