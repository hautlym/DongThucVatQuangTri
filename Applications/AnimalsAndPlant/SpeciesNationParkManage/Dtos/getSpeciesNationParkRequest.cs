using DongThucVatQuangTri.Applications.Common;

namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesNationParkManage.Dtos
{
    public class getSpeciesNationParkRequest:PageResultBase
    {
        public string? keyword { get; set; }
        public int? status { get; set; }
        public int? loai { get; set; }
        
    }
}
