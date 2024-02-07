using DongThucVatQuangTri.Applications.Common;

namespace DongThucVatQuangTri.Applications.Contacts.Dtos
{
    public class GetContactPaging: PageResultBase
    {
        public int? type { get; set; }
        public string? Keyword { get; set; }
        public int? status { get; set; }
        public string? typeNationPark { get; set; }
    }
}
