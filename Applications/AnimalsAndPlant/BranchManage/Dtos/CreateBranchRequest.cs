namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.BranchManage.Dtos
{
    public class CreateBranchRequest
    {
        public string Name { get; set; }
        public string NameLatinh { get; set; }
        public short? Loai { get; set; }
        public short? Status { get; set; }
        public DateTime? CreatedAt { get; set; }
        public int? CreatedBy { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public int? UpdatedBy { get; set; }
    }
}
