namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.SetManage.Dtos
{
    public class CreateSetRequest
    {
        public string Name { get; set; }
        public string NameLatinh { get; set; }
        public short? Loai { get; set; }
        public int? IdDtvLop { get; set; }
        public short? Status { get; set; }
        public string? CreatedBy { get; set; }
    }
}
