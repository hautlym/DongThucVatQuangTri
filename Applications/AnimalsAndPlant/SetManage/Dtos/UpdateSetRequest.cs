namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.SetManage.Dtos
{
    public class UpdateSetRequest
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string? NameLatinh { get; set; }
        public short? Loai { get; set; }
        public int? IdDtvLop { get; set; }
        public short? Status { get; set; }
        public string? UpdatedBy { get; set; }
    }
}
