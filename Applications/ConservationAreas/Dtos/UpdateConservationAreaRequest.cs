namespace DongThucVatQuangTri.Applications.ConservationAreas.Dtos
{
    public class UpdateConservationAreaRequest
    {
        public int Id { get; set; }
        public string NameConservation { get; set; }
        public string Address { get; set; }
        public string Phone { get; set; }
        public bool IsDelete { get; set; }
        public string Description { get; set; }
        public string Email { get; set; }
        public IFormFile? Image { get; set; }
        public string? linkUrl { get; set; }
    }
}
