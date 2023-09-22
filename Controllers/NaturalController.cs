using DongThucVatQuangTri.Applications.AnimalsAndPlant.BranchManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.ClassManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.FamilyManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SetManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage.Dtos;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage.DtosPublic;
using DongThucVatQuangTri.Applications.Enums;
using DongThucVatQuangTri.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.Drawing.Printing;

namespace DongThucVatQuangTri.Controllers
{
    public class NaturalController : Controller
    {
        private readonly IManageBranch _manageBranch;
        private readonly IManageClass _manageClass;
        private readonly IManageSet _manageSet;
        private readonly IManageFamily _manageFamily;
        private readonly IPublicManageSpecies _manageSpecies;
        public NaturalController(IManageBranch manageBranch, IManageClass manageClass, IManageFamily manageFamily,
            IManageSet manageSet, IPublicManageSpecies manageSpecies)
        {
            _manageBranch = manageBranch;
            _manageClass = manageClass;
            _manageFamily = manageFamily;
            _manageSet = manageSet;
            _manageSpecies = manageSpecies;

        }
   
        public async Task<IActionResult> Index(SearchModel searchModel, int PageIndex=1,int PageSize=20)
        {
            var request = new getSpeciesPublicRequest()
            {
                PageIndex = PageIndex,
                PageSize = PageSize,
                keyword = searchModel.keyword,
                loai = searchModel.IdLoai,
                keyword2 = searchModel.keyword2,
                sdvn= searchModel.sdvn,
                ndcp = searchModel.ndcp,
                nd64cp = searchModel.nd64cp,
                icun=searchModel.icun,
                id_bo = searchModel.id_bo,
                id_ho = searchModel.id_ho,
                id_lop=searchModel.id_lop,
                id_nganh = searchModel.id_nganh,
                status=1
            };
            
            if (searchModel.IdLoai == 1)
            {
                ViewBag.Loai = "Động Vật";
            }
            if (searchModel.IdLoai == 0)
            {
                ViewBag.Loai = "Thực vật";
            }
            var item = (await _manageBranch.getAllItem()).Where(x => x.Loai == searchModel.IdLoai).Where(x => x.Status == 1).ToList();
            ViewBag.NganhSearch = item.Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Id.ToString(),
            });
            var data = await _manageSpecies.GetAlllPaging(request);
            ViewBag.Keyword = searchModel.keyword;
            ViewBag.Nganh = item ;
            ViewBag.Lop = await _manageClass.getAllItem();
            ViewBag.Bo = await _manageSet.getAllItem();
            ViewBag.Ho = await _manageFamily.getAllItem();
            //ViewBag.Categories = ListItem.Where(x => x.Loai == loai).Select(x => new SelectListItem()
            //{
            //    Text = x.Name,
            //    Value = x.Id.ToString(),
            //});
            ViewBag.MucDoBaoTonIUCN = MucDoBaoTon.MuDoBaoTonIUCN.Select(x => new SelectListItem()
            {
                Text = x.Value,
                Value = x.Key.ToString(),

            });
            ViewBag.MucDoBaoTonSDVN = MucDoBaoTon.MuDoBaoTonSDVN.Select(x => new SelectListItem()
            {
                Text = x.Value,
                Value = x.Key.ToString(),
            });
            ViewBag.MucDoBaoTonNDCP = MucDoBaoTon.MuDoBaoTonNDCP[searchModel.IdLoai].Select(x => new SelectListItem()
            {
                Text = x.Value,
                Value = x.Key.ToString(),
            });
            
            return View(data.ResultObj);
        }
        [HttpGet]
        public async Task<IActionResult> Details(int Id)
        {
            var result = await _manageSpecies.getItemById(Id);
            var loai = result.Loai;
            var item = (await _manageBranch.getAllItem()).Where(x => x.Loai == loai).Where(x => x.Status == 1).ToList();

            ViewBag.Nganh = item;
            ViewBag.Lop = await _manageClass.getAllItem();
            ViewBag.Bo = await _manageSet.getAllItem();
            ViewBag.Ho = await _manageFamily.getAllItem();
            ViewBag.MucDoBaoTonIUCN = !String.IsNullOrEmpty(result.MucDoBaoTonIucn.ToString()) && result.MucDoBaoTonIucn != 0 ? MucDoBaoTon.MuDoBaoTonIUCN[(int)result.MucDoBaoTonIucn] : "";
            ViewBag.MucDoBaoTonSDVN = !String.IsNullOrEmpty(result.MucDoBaoTonSdvn.ToString()) && result.MucDoBaoTonSdvn != 0 ? MucDoBaoTon.MuDoBaoTonSDVN[(int)result.MucDoBaoTonSdvn] : "";
            ViewBag.MucDoBaoTonNDCP = !String.IsNullOrEmpty(result.MucDoBaoTonNdcp.ToString()) && result.MucDoBaoTonNdcp != 0 ? MucDoBaoTon.MuDoBaoTonNDCP[(int)loai][(int)result.MucDoBaoTonNdcp] : "";
            ViewBag.MucDoBaoTonND64CP = !String.IsNullOrEmpty(result.MucDoBaoTonNd64cp.ToString()) && result.MucDoBaoTonNd64cp != 0 ? MucDoBaoTon.MuDoBaoTonNDCP[(int)loai][(int)result.MucDoBaoTonNd64cp] : "";
            if (loai == 1)
            {
                ViewBag.Loai = "Động Vật";
            }
            if (loai == 0)
            {
                ViewBag.Loai = "Thực vật";
            }
            var detailsModels = new DetailsModels()
            {
                lisViewModels = (await _manageSpecies.getAllItem()).Where(x => x.IdDtvHo == result.IdDtvHo && x.Id != result.Id).Take(3).ToList(),
                speciesViewModels = result
            };
            return View(detailsModels);
        }
        [HttpPost]
        public  async Task<IActionResult> GetListLop(int IdNganh)
        {
            var item = (await _manageClass.getAllItem()).Where(x => x.IdDtvNganh == IdNganh)
                .Where(x => x.Status == 1).Select(x=>new SelectListItem {
                    Text = x.Name,
                    Value = x.Id.ToString(),
                }).ToList();
            return Json(item);
        }
        [HttpPost]
        public async Task<IActionResult> GetListBo(int idLop)
        {
            var item = (await _manageSet.getAllItem()).Where(x => x.IdDtvLop == idLop)
                .Where(x => x.Status == 1).Select(x => new SelectListItem
                {
                    Text = x.Name,
                    Value = x.Id.ToString(),
                }).ToList();
            return Json(item);
        }
        [HttpPost]
        public async Task<IActionResult> GetListHo(int idBo)
        {
            var item = (await _manageFamily.getAllItem()).Where(x => x.IdDtvBo == idBo)
                .Where(x => x.Status == 1).Select(x => new SelectListItem
                {
                    Text = x.Name,
                    Value = x.Id.ToString(),
                }).ToList();
            return Json(item);
        }
    }
}
