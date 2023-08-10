using DongThucVatQuangTri.Applications.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DongThucVatQuangTri.Applications.UserManage.Dtos
{
    public class GetUserPagingRequest : PagingRequestBase
    {
        public string? Keyword { get; set; }
    }
}
