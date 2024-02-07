using DongThucVatQuangTri.Applications.Common;

namespace DongThucVatQuangTri.Applications.ConservationAreas.Dtos
{
    public class getConservationPagingRequest: PageResultBase
    {
        public string? Keyword { get; set; }
    }
}
