using DongThucVatQuangTri.Applications.Common;

namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.FamilyManage.Dtos
{
    public class GetFamilyRequest:PageResultBase
    {
        public string? keyword { get; set; }
        public int? status { get; set; }
        public int? loai { get; set; }
    }
}
