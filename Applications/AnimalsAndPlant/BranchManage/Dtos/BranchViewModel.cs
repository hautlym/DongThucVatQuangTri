namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.BranchManage.Dtos
{
    public class BranchViewModel
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string NameLatinh { get; set; }
        public short? Loai { get; set; }
        public short? Status { get; set; }
        public DateTime? CreatedAt { get; set; }
        public string? CreatedBy { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public string? UpdatedBy { get; set; }
        public string? NameCreate { get; set; }
    }
}
