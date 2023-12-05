namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesNationParkManage.Dtos
{
    public class SpeciesNationParkViewModel
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string NameLatinh { get; set; }
        public short? Loai { get; set; }
        public string? NameHo { get; set; }
        public int? IdDtvHo { get; set; }
        public string TenKhac { get; set; }
        public string DacDiem { get; set; }
        public string GiaTriSuDung { get; set; }
        public string PhanBo { get; set; }
        public string FileDinhKem { get; set; }
        public string NguonTaiLieu { get; set; }
        public short? MucDoBaoTonIucn { get; set; }
        public short? MucDoBaoTonSdvn { get; set; }
        public short? MucDoBaoTonNdcp { get; set; }
        public short? MucDoBaoTonNd64cp { get; set; }
        public short? Status { get; set; }
        public DateTime? CreatedAt { get; set; }
        public string? CreatedBy { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public string? UpdatedBy { get; set; }
        public int IdDtvLoai { get; set; }
       public string? NameCreate { get; set; }
        public string? KinhDo { get; set; }
        public string? ViDo { get; set; }
    }
}
