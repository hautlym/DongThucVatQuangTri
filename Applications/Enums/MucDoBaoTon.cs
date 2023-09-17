using System.ComponentModel;

namespace DongThucVatQuangTri.Applications.Enums
{
    public static class MucDoBaoTon
    {
        public static Dictionary<int, string> MuDoBaoTonIUCN = new Dictionary<int, string>
        {
            { 1, "EX- Tuyệt Chủng" },
            { 2, "EW- Tuyệt chủng ngoài thiên nhiên" },
            { 3, "CR- Rất nguy cấp" },
            { 4, "EN- Nguy cấp" },
            { 5, "VU- Sẽ nguy cấp" },
            { 6, "LR- Ít nguy cấp" },
            { 7, "DD- Thiếu dẫn liệu" },
            { 8, "NE- Không đánh giá" },
        };
        public static Dictionary<int, string> MuDoBaoTonSDVN = new Dictionary<int, string>
        {
            { 21, "EX- Tuyệt Chủng" },
            { 22, "EW- Tuyệt chủng ngoài thiên nhiên" },
            { 23, "CR- Rất nguy cấp" },
            { 24, "EN- Nguy cấp" },
            { 25, "VU- Sẽ nguy cấp" },
            { 26, "LR- Ít nguy cấp" },
            { 27, "DD- Thiếu dẫn liệu" },
            { 28, "NE- Không đánh giá" },
        };
        public static Dictionary<int, Dictionary<int, string>> MuDoBaoTonNDCP = new Dictionary<int, Dictionary<int, string>>
        {
            { 0, new Dictionary<int, string>
                {
                    { 31, "Nhóm IA" },
                    { 32, "Nhóm IIA" }
                }
            },
            { 1, new Dictionary<int, string>
                {
                    { 41, "Nhóm IB" },
                    { 42, "Nhóm IIB" }
                }
            }
        };
    }
}
