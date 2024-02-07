using DongThucVatQuangTri.Applications.Enums;

namespace DongThucVatQuangTri.Applications.Contacts.Dtos
{
    public class UpdateContactRequest
    {
        public int Id { get; set; }
        public string? status{ get; set; }
        public string? Note { get; set; }
        public string? typeNationPark { get; set; }
    }
}
