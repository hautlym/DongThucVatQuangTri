namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.ClassManage.Dtos
{
    public class ClassViewModels
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string NameLatinh { get; set; }
        public short? Loai { get; set; }
        public int? IdDtvNganh { get; set; }
        public string? DtvNganhName { get; set; }
        public short? Status { get; set; }
        public DateTime? CreatedAt { get; set; }
        public string CreatedBy { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public string? UpdatedBy { get; set; }
    }
}
