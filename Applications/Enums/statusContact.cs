using System.Runtime.Serialization;

namespace DongThucVatQuangTri.Applications.Enums
{

    public enum statusContact
    {
        [EnumMember(Value = "Đã trả lời")]
        Responsed,
        [EnumMember(Value = "Chưa trả lời")]
        NotRespond,
    }

}
