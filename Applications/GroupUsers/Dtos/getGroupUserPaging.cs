using DongThucVatQuangTri.Applications.Common;

namespace DongThucVatQuangTri.Applications.GroupUsers.Dtos
{
    public class getGroupUserPaging: PageResultBase
    {
        public string? Keyword { get; set; }
    }
}
