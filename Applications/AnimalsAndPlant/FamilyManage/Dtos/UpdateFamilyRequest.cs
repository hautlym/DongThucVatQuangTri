namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.FamilyManage.Dtos
{
    public class UpdateFamilyRequest
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string? NameLatinh { get; set; }
        public short? Loai { get; set; }
        public int? IdDtvBo { get; set; }
        public short? Status { get; set; }
        public string? UpdatedBy { get; set; }
    }
}
