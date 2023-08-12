namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.FamilyManage.Dtos
{
    public class FamilyViewModels
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string NameLatinh { get; set; }
        public short? Loai { get; set; }
        public int? IdDtvBo { get; set; }
        public string BoName { get; set; }
        public short? Status { get; set; }
        public DateTime? CreatedAt { get; set; }
        public string? CreatedBy { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public string? UpdatedBy { get; set; }
    }
}
