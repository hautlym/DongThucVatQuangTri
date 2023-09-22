namespace DongThucVatQuangTri.Models.Entities
{
    public class DtvLoai_VQG
    {
        public int Id { get; set; }
        public int IdDtvLoai { get; set; }
        public string? TenKhac { get; set; }
        public string? DacDiem { get; set; }
        public string? GiaTriSuDung { get; set; }
        public string? PhanBo { get; set; }
        public short? Status { get; set; }
        public short? Loai { get; set; }
        public string? FileDinhKem { get; set; }
        public string? NguonTaiLieu { get; set; }
        public DateTime? CreatedAt { get; set; }
        public string? CreatedBy { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public string? UpdatedBy { get; set; }
    }
}
