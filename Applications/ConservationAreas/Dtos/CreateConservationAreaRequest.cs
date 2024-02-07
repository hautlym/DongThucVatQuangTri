namespace DongThucVatQuangTri.Applications.ConservationAreas.Dtos
{
    public class CreateConservationAreaRequest
    {
        public string NameConservation { get; set; }
        public string Address { get; set; }
        public string Phone { get; set; }
        public string Description { get; set; }
        public string Email { get; set; }
        public IFormFile? Image { get; set; }
    }
}
