using System.ComponentModel.DataAnnotations;

namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.SetManage.Dtos
{
    public class UpdateSetRequest
    {
        public long Id { get; set; }
        [Required(ErrorMessage = "Vui lòng điền tên tiếng Việt")]
        public string Name { get; set; }
        [Required(ErrorMessage = "Vui lòng điền tên tiếng Anh")]
        public string NameLatinh { get; set; }
        public short? Loai { get; set; }
        public int? IdDtvLop { get; set; }
        public short? Status { get; set; }
        public string? UpdatedBy { get; set; }
    }
}
