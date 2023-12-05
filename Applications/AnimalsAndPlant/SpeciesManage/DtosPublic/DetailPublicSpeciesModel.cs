using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesNationParkManage.Dtos;
using DongThucVatQuangTri.Models.Entities;

namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage.DtosPublic
{
    public class DetailPublicSpeciesModel
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string NameLatinh { get; set; }
        public short? Loai { get; set; }
        public string? NameHo { get; set; }
        public int? IdDtvHo { get; set; }
        
        public short? MucDoBaoTonIucn { get; set; }
        public short? MucDoBaoTonSdvn { get; set; }
        public short? MucDoBaoTonNdcp { get; set; }
        public short? MucDoBaoTonNd64cp { get; set; }
        public short? Status { get; set; }
        public DtvLoai_VQG? VQgNamGiang { get; set; }
        public DtvLoai_VQG? VQGMuongTe { get; set; }
    }
}
