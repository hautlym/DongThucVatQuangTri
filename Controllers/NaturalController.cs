using DongThucVatQuangTri.Applications.AnimalsAndPlant.BranchManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.ClassManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.FamilyManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SetManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage.Dtos;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage.DtosPublic;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesNationParkManage;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.Enums;
using DongThucVatQuangTri.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Newtonsoft.Json;
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
        private readonly IManageSpeciesNationPark _manageSpeciesNationPark;
        public NaturalController(IManageBranch manageBranch, IManageClass manageClass, IManageFamily manageFamily,
            IManageSet manageSet, IPublicManageSpecies manageSpecies, IManageSpeciesNationPark manageSpeciesNationPark)
        {
            _manageBranch = manageBranch;
            _manageClass = manageClass;
            _manageFamily = manageFamily;
            _manageSet = manageSet;
            _manageSpecies = manageSpecies;
            _manageSpeciesNationPark = manageSpeciesNationPark;
        }

        [HttpGet]
        public async Task<IActionResult> Index(SearchModel searchModel, int PageIndex = 1, int PageSize = 20)
        {

            // Lấy SearchModel từ session
            var sessionSearchModel = HttpContext.Session.GetString("SearchModel");
            var typeNationPark = HttpContext.Session.GetString("NationPark");
            if (String.IsNullOrEmpty(searchModel.vqg) || typeNationPark != "All")
            {
                searchModel.vqg = typeNationPark;
            }
            SearchModel storedSearchModel = null;

            if (!string.IsNullOrEmpty(sessionSearchModel))
            {
                storedSearchModel = JsonConvert.DeserializeObject<SearchModel>(sessionSearchModel);
            }

            // Sử dụng reflection để kiểm tra nếu SearchModel truyền lên khác với SearchModel trong session
            bool hasSearchChanged = storedSearchModel == null ||
                                    !HelperMethod.AreEqual(searchModel, storedSearchModel);

            // Nếu có thay đổi, ghi đè session với SearchModel mới
            if (hasSearchChanged)
            {
                HttpContext.Session.SetString("SearchModel", JsonConvert.SerializeObject(searchModel));
            }
            else
            {
                // Nếu không có thay đổi, lấy lại SearchModel từ session
                searchModel = storedSearchModel;
            }


            
            var request = new getSpeciesPublicRequest()
            {
                PageIndex = PageIndex,
                PageSize = PageSize,
                keyword = searchModel.keyword,
                loai = searchModel.IdLoai,
                keyword2 = searchModel.keyword2,
                sdvn = searchModel.sdvn,
                ndcp = searchModel.ndcp,
                nd64cp = searchModel.nd64cp,
                icun = searchModel.icun,
                id_bo = searchModel.id_bo,
                id_ho = searchModel.id_ho,
                id_lop = searchModel.id_lop,
                id_nganh = searchModel.id_nganh,
                vqg = searchModel.vqg == "All" ? "" : searchModel.vqg,
                status = 1
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
                Selected = x.Id == searchModel.id_nganh
            });
            var data = await _manageSpecies.GetAlllPaging(request);
            ViewBag.Keyword = searchModel.keyword;
            ViewBag.Nganh = item;
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
                Selected= x.Key==searchModel.icun
            });
            ViewBag.MucDoBaoTonSDVN = MucDoBaoTon.MuDoBaoTonSDVN.Select(x => new SelectListItem()
            {
                Text = x.Value,
                Value = x.Key.ToString(),
                Selected = x.Key==searchModel.sdvn
            });
            ViewBag.MucDoBaoTonNDCP = MucDoBaoTon.MuDoBaoTonNDCP[searchModel.IdLoai].Select(x => new SelectListItem()
            {
                Text = x.Value,
                Value = x.Key.ToString(),
                Selected = x.Key==searchModel.ndcp
            });
            ViewBag.MucDoBaoTonND64CP = MucDoBaoTon.MuDoBaoTonNDCP[searchModel.IdLoai].Select(x => new SelectListItem()
            {
                Text = x.Value,
                Value = x.Key.ToString(),
                Selected = x.Key == searchModel.nd64cp
            });
            return View(data.ResultObj);
        }
        [HttpGet]
        public async Task<IActionResult> Details(int Id, string currentUrl = "")
        {
            try
            {
                var result1 = await _manageSpeciesNationPark.getItemById(Id);
                var result = await _manageSpecies.getItemById(result1.IdDtvLoai);
                var loai = result.Loai;
                var item = (await _manageBranch.getAllItem()).Where(x => x.Loai == loai).Where(x => x.Status == 1).ToList();

                ViewBag.Nganh = item;
                ViewBag.Lop = await _manageClass.getAllItem();
                ViewBag.Bo = await _manageSet.getAllItem();
                ViewBag.Ho = await _manageFamily.getAllItem();
                ViewBag.CurrentUrl = currentUrl;
                if (MucDoBaoTon.MuDoBaoTonIUCN.ContainsKey(result.MucDoBaoTonIucn ?? 100))
                {
                    ViewBag.MucDoBaoTonIUCN = !String.IsNullOrEmpty(result.MucDoBaoTonIucn.ToString()) && result.MucDoBaoTonIucn != 0 ? MucDoBaoTon.MuDoBaoTonIUCN[(int)result.MucDoBaoTonIucn] : "";
                }
                if (MucDoBaoTon.MuDoBaoTonSDVN.ContainsKey(result.MucDoBaoTonSdvn ?? 100))
                {
                    ViewBag.MucDoBaoTonSDVN = !String.IsNullOrEmpty(result.MucDoBaoTonSdvn.ToString()) && result.MucDoBaoTonSdvn != 0 ? MucDoBaoTon.MuDoBaoTonSDVN[(int)result.MucDoBaoTonSdvn] : "";
                }
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
                var listVQG = (await _manageSpeciesNationPark.getAllItem()).Where(x => x.IdDtvLoai == result.Id).ToList();
                var detailsModels = new DetailsModels()
                {
                    lisViewModels = (await _manageSpecies.getAllItem()).Where(x => x.IdDtvHo == result.IdDtvHo && x.Id != result.Id).Take(2).ToList(),
                    speciesViewModels = result
                };
                return View(detailsModels);
            }
            catch(Exception ex)
            {
                throw new Exception(ex.Message);
            }
           
        }
        [HttpPost]
        public async Task<IActionResult> GetListLop(int IdNganh)
        {
            var item = (await _manageClass.getAllItem()).Where(x => x.IdDtvNganh == IdNganh)
                .Where(x => x.Status == 1).Select(x => new SelectListItem
                {
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
