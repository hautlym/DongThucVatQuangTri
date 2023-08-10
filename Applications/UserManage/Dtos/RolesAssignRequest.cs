using DongThucVatQuangTri.Applications.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DongThucVatQuangTri.Applications.UserManage.Dtos
{
    public class RolesAssignRequest
    {

        public Guid Id { get; set; }
        public List<SelectedItem> Roles { get; set; } = new List<SelectedItem>();
    }
}
