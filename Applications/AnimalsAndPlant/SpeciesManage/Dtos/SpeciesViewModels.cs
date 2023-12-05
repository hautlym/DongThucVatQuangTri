namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage.Dtos
{
    public class SpeciesViewModels
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
        public DateTime? CreatedAt { get; set; }
        public string? CreatedBy { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public string? UpdatedBy { get; set; }
        public string? NameCreate { get; set; }
    }
}
