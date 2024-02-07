using DongThucVatQuangTri.Applications.Enums;
using DongThucVatQuangTri.Models.Entities;
using System.Reflection;
using System.Runtime.Serialization;
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
                if (userItem.Equals(userIdentityRole))
                {
                    return true;
                }else if(userItem.Equals(userIdentityId))
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
        public static class EnumExtensions
        {
            public static string GetEnumMemberValue(Enum value)
            {
                Type type = value.GetType();
                MemberInfo[] memInfo = type.GetMember(value.ToString());

                if (memInfo != null && memInfo.Length > 0)
                {
                    object[] attrs = memInfo[0].GetCustomAttributes(typeof(EnumMemberAttribute), false);

                    if (attrs != null && attrs.Length > 0)
                        return ((EnumMemberAttribute)attrs[0]).Value;
                }

                return value.ToString();
            }
        }
    }
}
