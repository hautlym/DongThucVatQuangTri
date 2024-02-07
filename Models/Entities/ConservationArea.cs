namespace DongThucVatQuangTri.Models.Entities
{
    public class ConservationArea
    {
        public int Id { get; set; }
        public string? Image { get; set; }
        public string NameConservation { get; set; }
        public string Address { get; set; }
        public string Phone { get; set; }
        public string Description { get; set; }
        public string Email { get; set; }
        public DateTime? CreateAt { get; set; }
        public DateTime? UpdateAt { get; set; }
        
    }
}
