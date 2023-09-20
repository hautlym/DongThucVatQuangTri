using DongThucVatQuangTri.Applications.Enums;
using DongThucVatQuangTri.Models.Entities;
using System.Security.Claims;

namespace DongThucVatQuangTri.Applications.Common
{
    public static class HelperMethod
    {
        public static bool CheckUser(string userItem, ClaimsPrincipal userLogin)
        {
            try
            {
                var userIdentityId = userLogin.FindFirst(ClaimTypes.NameIdentifier).Value;
                var userIdentityRole = userLogin.FindFirst(ClaimTypes.Role).Value;
                if (userIdentityRole.Equals("Administator"))
                {
                    return true;
                }
                if(String.IsNullOrEmpty(userItem)) { return false; }
                if (userItem.Equals(userIdentityId))
                {
                    return true;
                }
                else
                {
                    return false;
                }

            }catch(Exception ex)
            {
                return false;
            }
        }
    }
}
