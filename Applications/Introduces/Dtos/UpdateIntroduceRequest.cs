using System.ComponentModel.DataAnnotations;

namespace DongThucVatQuangTri.Applications.Introduces.Dtos
{
    public class UpdateIntroduceRequest
    {
        public int id { get; set; }
        [Required(ErrorMessage = "Vui lòng điền nội dung")]

        public string content { get; set; }
        public string UpdateBy { get; set; }
    }
}
