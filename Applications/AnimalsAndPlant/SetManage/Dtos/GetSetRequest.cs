using DongThucVatQuangTri.Applications.Common;

namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.SetManage.Dtos
{
    public class GetSetRequest:PageResultBase
    {
        public string? keyword { get; set; }
        public int? status { get; set; }
        public int? loai { get; set; }
    }
}
