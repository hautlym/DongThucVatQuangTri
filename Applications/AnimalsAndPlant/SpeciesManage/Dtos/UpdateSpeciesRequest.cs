﻿namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage.Dtos
{
    public class UpdateSpeciesRequest
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string? NameLatinh { get; set; }
        public short? Loai { get; set; }
        public int? IdDtvHo { get; set; }
        public string? TenKhac { get; set; }
        public string? DacDiem { get; set; }
        public string? GiaTriSuDung { get; set; }
        public string? PhanBo { get; set; }
        public bool isDelete { get; set; }
        public List<IFormFile>? FileDinhKem { get; set; }
        public string? HinhAnh { get; set; }
        public string? NguonTaiLieu { get; set; }
        public short? MucDoBaoTonIucn { get; set; }
        public short? MucDoBaoTonSdvn { get; set; }
        public short? MucDoBaoTonNdcp { get; set; }
        public short? MucDoBaoTonNd64cp { get; set; }
        public short? Status { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public string? UpdatedBy { get; set; }
    }
}