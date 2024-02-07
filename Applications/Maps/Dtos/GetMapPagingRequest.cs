using DongThucVatQuangTri.Applications.Common;

namespace DongThucVatQuangTri.Applications.Maps.Dtos
{
    public class GetMapPagingRequest:PageResultBase
    {
        public string? Keyword { get; set; }
        public int? status { get; set; }
        public int? typeMap { get; set; }

    }
}
