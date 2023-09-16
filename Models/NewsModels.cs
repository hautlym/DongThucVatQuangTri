using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage.Dtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.NewsItem.Dtos.NewsDtos;
using Microsoft.EntityFrameworkCore.Metadata.Internal;

namespace DongThucVatQuangTri.Models
{
    public class NewsModels
    {
        public List<NewsViewModels> isHotNew;
        public PageResult<NewsViewModels> ListNewsPagi;
        public List<NewsViewModels> ViewestNews;
        public NewsViewModels BannerNews;
    }
}
