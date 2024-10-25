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
        public static bool AreEqual<T>(T obj1, T obj2)
        {
            if (obj1 == null || obj2 == null)
                return false;

            // Lấy tất cả các thuộc tính của đối tượng
            var properties = typeof(T).GetProperties();

            foreach (var property in properties)
            {
                var value1 = property.GetValue(obj1);
                var value2 = property.GetValue(obj2);

                // Kiểm tra nếu hai giá trị không giống nhau (kể cả null)
                if (value1 != null && value2 != null)
                {
                    if (!value1.Equals(value2))
                        return false;
                }
                else if (value1 == null && value2 != null || value1 != null && value2 == null)
                {
                    return false;
                }
            }
            return true;
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
