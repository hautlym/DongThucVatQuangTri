using System.Runtime.Serialization;

namespace DongThucVatQuangTri.Applications.Enums
{
    public enum typeMap
    {
        [EnumMember(Value = "bản đồ địa hình")]
        TopographicMaps,
        [EnumMember(Value = "bản đồ khí hậu")]
        ClimateMap,
        [EnumMember(Value = "bản đồ thổ nhưỡng")]
        SoilMap,
        [EnumMember(Value = "bản đồ sinh thái")]
        EcologicalMap,
        [EnumMember(Value = "bản đồ hiện trạng rừng")]
        ForestStatusMap,
    }
}
