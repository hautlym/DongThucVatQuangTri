namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesNationParkManage.Dtos
{
    public class CreateSpeciesNationParkRequest
    {
        public int IdDtvLoai { get; set; }
        public string? TenKhac { get; set; }
        public string? DacDiem { get; set; }
        public string? GiaTriSuDung { get; set; }
        public string? PhanBo { get; set; }
        public short? Loai { get; set; }
        public short? Status { get; set; }
        public List<IFormFile>? FileDinhKem { get; set; }
        public string? KinhDo { get; set; }
        public string? ViDo { get; set; }
        public string? NguonTaiLieu { get; set; }
        public DateTime? CreatedAt { get; set; }
        public string? CreatedBy { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public string? typeNationPark { get; set; }
    }
}
