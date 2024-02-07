using DongThucVatQuangTri.Applications.Common;

namespace DongThucVatQuangTri.Applications.EcotourismSafeties.Dtos
{
    public class GetEcotourismSafetyPagingRequest : PageResultBase
    {
        public int? type { get; set; }
        public string? Keyword { get; set; }
        public int? status { get; set; }
        public string? typeNationPark { get; set; }
    }
}
