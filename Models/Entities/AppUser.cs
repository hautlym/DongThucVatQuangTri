using Microsoft.AspNetCore.Identity;

namespace DongThucVatQuangTri.Models.Entities
{
    public class AppUser:IdentityUser<Guid>
    {
        public string FirstName { get; set; }
        public string? LastName { get; set; }
        public long? CitiesId { get; set; }
        public long? CitiesDistrictId { get; set; }
        public string? Avatar { get; set; }
        public string Gender { get; set; }
        public DateTime? Dob { get; set; }
        public string Address { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }
        public DateTime? LastSigninedTime { get; set; }
        public short IsAdmin { get; set; }
        public short Status { get; set; }
        public string Roles { get; set; }
    }
}
