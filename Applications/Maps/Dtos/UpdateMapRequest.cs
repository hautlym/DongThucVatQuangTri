namespace DongThucVatQuangTri.Applications.Maps.Dtos
{
    public class UpdateMapRequest
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string Url { get; set; }
        public IFormFile? linkMap { get; set; }
        public string? UpdateBy { get; set; }
    }
}
