using DongThucVatQuangTri.Applications.Common;

namespace DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage.Dtos
{
    public class GetSpeciesRequest:PageResultBase
    {
        public string? keyword { get; set; }
        public int? status { get; set; } 
        public int? loai { get; set; }
    
    }
}
