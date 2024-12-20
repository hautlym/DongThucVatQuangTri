using System.ComponentModel.DataAnnotations;

namespace DongThucVatQuangTri.Applications.ConservationAreas.Dtos
{
    public class CreateConservationAreaRequest
    {

        [Required(ErrorMessage = "Vui lòng điền tên")]
        public string NameConservation { get; set; }

        [Required(ErrorMessage = "Vui lòng điền địa chỉ")]
        public string Address { get; set; }

        [Required(ErrorMessage = "Vui lòng điền số điện thoại")]
        public string Phone { get; set; }

        [Required(ErrorMessage = "Vui lòng điền mô tả")]
        public string Description { get; set; }

        [Required(ErrorMessage = "Vui lòng điền email")]
        public string Email { get; set; }
        public IFormFile? Image { get; set; }
    }
}
