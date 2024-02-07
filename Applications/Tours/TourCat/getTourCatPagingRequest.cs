using DongThucVatQuangTri.Applications.Common;

namespace DongThucVatQuangTri.Applications.Tours.TourCat
{
    public class getTourCatPagingRequest: PageResultBase
    {
        public string? Keyword { get; set; }
        public int? status { get; set; }
        public string? typeNationPark { get; set; }
    }
}
