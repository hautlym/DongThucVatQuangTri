using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DongThucVatQuangTri.Models.Entities
{
    public class AppUser : IdentityUser<Guid>
    {
        public long? CitiesId { get; set; }
        public long? CitiesDistrictId { get; set; }
        public string FullName { get; set; }
        public string? Avatar { get; set; }
        public DateTime Dob { get; set; }
        public DateTime RegisterDay { get; set; }
        public DateTime UpdateDay { get; set; }
        public DateTime LastLogin { get; set; }
        public string sex { get; set; }

        public List<DtvNganh> Nganh { get; set; }
        


    }
}
