namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.SetManage.Dtos
{
    public class SetViewModels
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string NameLatinh { get; set; }
        public short? Loai { get; set; }
        public string NameLop { get; set; }
        public int? IdDtvLop { get; set; }
        public short? Status { get; set; }
        public DateTime? CreatedAt { get; set; }
        public string? CreatedBy { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public string? UpdatedBy { get; set; }
        public string? NameCreate { get; set; }
    }
}
