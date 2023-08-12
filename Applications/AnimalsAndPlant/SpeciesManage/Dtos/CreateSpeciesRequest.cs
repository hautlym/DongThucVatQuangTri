namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage.Dtos
{
    public class CreateSpeciesRequest
    {
        public string Name { get; set; }
        public string? NameLatinh { get; set; }
        public short? Loai { get; set; }
        public int? IdDtvHo { get; set; }
        public string? TenKhac { get; set; }
        public string? DacDiem { get; set; }
        public string? GiaTriSuDung { get; set; }
        public string? PhanBo { get; set; }
        public List<IFormFile>? FileDinhKem { get; set; }
        public string? NguonTaiLieu { get; set; }
        public short? MucDoBaoTonIucn { get; set; }
        public short? MucDoBaoTonSdvn { get; set; }
        public short? MucDoBaoTonNdcp { get; set; }
        public short? MucDoBaoTonNd64cp { get; set; }
        public short? Status { get; set; }
        public string? CreatedBy { get; set; }
        public int? UpdatedBy { get; set; }
    }
}
