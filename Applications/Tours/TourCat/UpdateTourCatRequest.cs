using System.ComponentModel.DataAnnotations;

namespace DongThucVatQuangTri.Applications.Tours.TourCat
{
    public class UpdateTourCatRequest
    {
        public long Id { get; set; }
        [Required(ErrorMessage = "Vui lòng điền tên ")]

        public string Name { get; set; }
        [Required(ErrorMessage = "Vui lòng điền alias ")]

        public string Alias { get; set; }
        public string? linkUrl { get; set; }
        public bool isDelete { get; set; }
        public IFormFile? Image { get; set; }
        public string? Description { get; set; }
        [Required(ErrorMessage = "Vui lòng điền thứ tự ")]

        public int SortOrder { get; set; }
        public short Status { get; set; }
        public string? typeNationPark { get; set; }
        public string? UpdateBy { get; set; }
    }
}
