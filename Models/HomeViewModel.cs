using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage.Dtos;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage.DtosPublic;
using DongThucVatQuangTri.Applications.Banners.Dtos.BannerDtos;

namespace DongThucVatQuangTri.Models
{
    public class HomeViewModel
    {
        public List<BannerViewModels> bannerViews { get; set; }
        public List<SpeciesPublicViewModel> donngvat;
        public List<SpeciesPublicViewModel> thucvat;
    }
}
