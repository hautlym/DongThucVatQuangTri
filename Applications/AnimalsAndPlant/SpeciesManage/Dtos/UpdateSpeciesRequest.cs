using System.ComponentModel.DataAnnotations;

namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage.Dtos
{
    public class UpdateSpeciesRequest
    {
        public long Id { get; set; }
        [Required(ErrorMessage = "Vui lòng điền tên tiếng Việt")]
        public string Name { get; set; }
        [Required(ErrorMessage = "Vui lòng điền tên tiếng Anh")]
        public string? NameLatinh { get; set; }
        public short? Loai { get; set; }
        public int? IdDtvHo { get; set; }
        public short? MucDoBaoTonIucn { get; set; }
        public short? MucDoBaoTonSdvn { get; set; }
        public short? MucDoBaoTonNdcp { get; set; }
        public short? MucDoBaoTonNd64cp { get; set; }
        public short? Status { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public string? UpdatedBy { get; set; }
    }
}
