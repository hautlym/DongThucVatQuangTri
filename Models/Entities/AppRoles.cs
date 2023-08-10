using Microsoft.AspNetCore.Identity;

namespace DongThucVatQuangTri.Models.Entities
{
    public class AppRoles : IdentityRole<Guid>
    {
        public string Description { get; set; }

    }
}
