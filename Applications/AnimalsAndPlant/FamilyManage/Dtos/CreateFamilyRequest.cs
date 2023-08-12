namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.FamilyManage.Dtos
{
    public class CreateFamilyRequest
    {
        public string Name { get; set; }
        public string? NameLatinh { get; set; }
        public short? Loai { get; set; }
        public int? IdDtvBo { get; set; }
        public short? Status { get; set; }
        public string? CreatedBy { get; set; }
        public string? UpdatedBy { get; set; }
    }
}
