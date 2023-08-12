namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.BranchManage.Dtos
{
    public class UpdateBranchRequest
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string? NameLatinh { get; set; }
        public short? Status { get; set; }
        public string? UpdatedBy { get; set; }
    }
}
