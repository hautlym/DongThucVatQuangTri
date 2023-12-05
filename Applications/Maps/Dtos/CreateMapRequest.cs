namespace DongThucVatQuangTri.Applications.Maps.Dtos
{
    public class CreateMapRequest
    {
        public string Name { get; set; }
        public string Description { get; set; }
        public IFormFile linkMap { get; set; }
        public string? CreateBy { get; set; }
    }
}
