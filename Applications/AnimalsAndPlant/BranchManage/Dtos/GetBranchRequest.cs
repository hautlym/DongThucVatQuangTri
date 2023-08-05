using DongThucVatQuangTri.Applications.Common;

namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.BranchManage.Dtos
{
    public class GetBranchRequest: PagingRequestBase
    {
        public string? keyword { get; set; }
    }
}
