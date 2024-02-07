namespace DongThucVatQuangTri.Models.Entities
{
    public class Contact
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public string NumberPhone { get; set; }
        public string Message { get; set; }
        public DateTime? CreateAt { get; set; }
        public DateTime? ResponseAt { get; set; }
        public string status { get; set; }
        public string? Note { get; set; }
        public string? typeNationPark { get; set; }
    }
}
