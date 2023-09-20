namespace DongThucVatQuangTri.Models.Entities
{
    public class DtvLoai_VQG
    {
        public int Id { get; set; }
        public int? IdDtvHo { get; set; }
        public string FileDinhKem { get; set; }
        public string NguonTaiLieu { get; set; }
        public string Name { get; set; }
        public string NameLatinh { get; set; }
        public string TenKhac { get; set; }
        public string DacDiem { get; set; }
        public string GiaTriSuDung { get; set; }
        public string PhanBo { get; set; }
    }
}
