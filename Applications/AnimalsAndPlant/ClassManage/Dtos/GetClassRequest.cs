using DongThucVatQuangTri.Applications.Common;

namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.ClassManage.Dtos
{
    public class GetClassRequest:PageResultBase
    {
        public string? keyword { get; set; }
        public int? status { get; set; }
        public int? loai { get; set; }
    }
}
