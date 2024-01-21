namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesNationParkManage.Dtos
{
    public class UpdateSpeciesNationParkRequest
    {
        public int Id { get; set; }
        public int IdDtvLoai { get; set; }
        public string? TenKhac { get; set; }
        public string? DacDiem { get; set; }
        public string? GiaTriSuDung { get; set; }
        public string? PhanBo { get; set; }
        public string? HinhAnh { set; get; }
        public bool isDelete { get; set; }
        public short? Loai { get; set; }
        public short? Status { get; set; }
        public List<IFormFile>? FileDinhKem { get; set; }
        public string? KinhDo { get; set; }
        public string? ViDo { get; set; }
        public string? NguonTaiLieu { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public string? UpdatedBy { get; set; }
        public string? TypeNationPark { get; set; }
    }
}
