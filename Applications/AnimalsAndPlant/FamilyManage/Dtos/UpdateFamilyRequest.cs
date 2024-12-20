using System.ComponentModel.DataAnnotations;

namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.FamilyManage.Dtos
{
    public class UpdateFamilyRequest
    {
        public long Id { get; set; }
        [Required(ErrorMessage = "Vui lòng điền tên tiếng Việt")]
        public string Name { get; set; }
        [Required(ErrorMessage = "Vui lòng điền tên tiếng Anh")]
        public string NameLatinh { get; set; }
        public short? Loai { get; set; }
        public int? IdDtvBo { get; set; }
        public short? Status { get; set; }
        public string? UpdatedBy { get; set; }
    }
}
