using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DongThucVatQuangTri.Models.Entities
{
    public class AppRoles : IdentityRole<Guid>
    {
        public string Description { get; set; }

    }
}
