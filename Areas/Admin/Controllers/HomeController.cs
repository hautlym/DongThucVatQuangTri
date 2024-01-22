using DongThucVatQuangTri.Applications.AnimalsAndPlant.BranchManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.ClassManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.FamilyManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SetManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesNationParkManage;
using DongThucVatQuangTri.Applications.AnimalsAndPlant.SpeciesNationParkManage.Dtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Areas.Admin.Models;
using DongThucVatQuangTri.Models.EF;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Security.Cryptography;

namespace DongThucVatQuangTri.Areas.Admin.Controllers
{

    [Area("admin")]
    [Authorize]
    public class HomeController : BaseController
    {
        private readonly IManageBranch _manageBranch;
        private readonly IManageClass _manageClass;
        private readonly IManageSet _manageSet;
        private readonly IManageFamily _manageFamily;
        private readonly IManageSpecies _manageSpecies;
        private readonly IManageSpeciesNationPark _manageSpeciesNationPark;
        private readonly DongThucVatContext _context;
        public HomeController(IManageSpeciesNationPark manageSpeciesNationPark, IManageSpecies manageSpecies, IManageSet manageSet,
            IManageFamily manageFamily, IManageClass manageClass, IManageBranch manageBranch, DongThucVatContext context)
        {
            _manageSpecies = manageSpecies;
            _manageBranch = manageBranch;
            _manageClass = manageClass;
            _manageSet = manageSet;
            _manageFamily = manageFamily;
            _manageSpeciesNationPark = manageSpeciesNationPark;
            _context = context;
        }
        public IActionResult Index()
        {
            return View();
        }
        [HttpGet]
        public IActionResult statistical()
        {
            if (TempData["result"] != null)
            {
                ViewBag.SuscessMsg = TempData["result"];
            }
            if (TempData["error"] != null)
            {
                ViewBag.ErrorMsg = TempData["error"];
            }
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> ExportExcel(int vqg, string fileName)
        {


            if (vqg == 0)
            {
                TempData["error"] = "Vui lòng chọn vườn quốc gia";
                return RedirectToAction("statistical");
            }
            if (String.IsNullOrEmpty(fileName))
            {
                TempData["error"] = "Vui lòng nhập tên muốn lưu";
                return RedirectToAction("statistical");
            }

            var listVQG = await _manageSpeciesNationPark.getAllItem();
            if (vqg == 1)
            {
                var newData = new List<SpeciesNationParkViewModel>();
                foreach (var item in listVQG)
                {
                    var checkRoleUser = _context.appUsers.Where(x => x.Id.ToString() == item.CreatedBy).Select(x => x.Roles).FirstOrDefault();
                    if (checkRoleUser == "NationParkMuongTe")
                    {
                        newData.Add(item);
                    }
                }
                listVQG = newData;
            }
            if (vqg == 2)
            {
                var newData = new List<SpeciesNationParkViewModel>();
                foreach (var item in listVQG)
                {
                    var checkRoleUser = _context.appUsers.Where(x => x.Id.ToString() == item.CreatedBy).Select(x => x.Roles).FirstOrDefault();
                    if (checkRoleUser == "NationParkNamGiang")
                    {
                        newData.Add(item);
                    }
                }
                listVQG = newData;
            }
            var listExport = new List<StatisticalModel>();
            foreach (var item in listVQG)
            {
                try
                {
                    var loai = await _manageSpecies.getItemById(item.IdDtvLoai);
                    var ho = await _manageFamily.getItemById(loai.IdDtvHo ?? 0);
                    var bo = await _manageSet.getItemById(ho.IdDtvBo ?? 0);
                    var lop = await _manageClass.getItemById(bo.IdDtvLop ?? 0);
                    var nganh = await _manageBranch.getItemById(lop.IdDtvNganh ?? 0);
                    var itemExport = new StatisticalModel()
                    {
                        Nganh = nganh.Name,
                        Lop = lop.Name,
                        Bo = bo.Name,
                        Ho = ho.Name,
                        LoaiTA = loai.NameLatinh,
                        LoaiTV = loai.Name,
                        PhanBo = item.PhanBo,
                        KinhDo = item.KinhDo,
                        ViDo = item.ViDo,
                    };
                    listExport.Add(itemExport);
                }
                catch (Exception ex)
                {
                    continue;
                }
            }

            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;
            using (ExcelPackage excelPackage = new ExcelPackage())
            {
                ExcelWorksheet worksheet = excelPackage.Workbook.Worksheets.Add("Sheet1");
                worksheet.Cells[1, 1].Value = "STT";
                worksheet.Cells[1, 2].Value = "Ngành";
                worksheet.Cells[1, 3].Value = "Lớp";
                worksheet.Cells[1, 4].Value = "Bộ";
                worksheet.Cells[1, 5].Value = "Họ";
                worksheet.Cells[1, 6].Value = "Tên loài (Tiếng Việt)";
                worksheet.Cells[1, 7].Value = "Tên loài (Tiếng Anh)";
                worksheet.Cells[1, 8].Value = "Phân bố";
                worksheet.Cells[1, 9].Value = "Kinh độ";
                worksheet.Cells[1, 10].Value = "Vĩ độ";
                int row = 2;
                using (ExcelRange range = worksheet.Cells["A1:J1"])
                {
                    range.Style.Font.Bold = true;
                    range.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    range.Style.Fill.BackgroundColor.SetColor(Color.LightGray);
                }
                foreach (var item in listExport)
                {
                    worksheet.Cells[row, 1].Value = row - 1;
                    worksheet.Cells[row, 2].Value = item.GetType().GetProperty("Nganh").GetValue(item, null);
                    worksheet.Cells[row, 3].Value = item.GetType().GetProperty("Lop").GetValue(item, null);
                    worksheet.Cells[row, 4].Value = item.GetType().GetProperty("Bo").GetValue(item, null);
                    worksheet.Cells[row, 5].Value = item.GetType().GetProperty("Ho").GetValue(item, null);
                    worksheet.Cells[row, 6].Value = item.GetType().GetProperty("LoaiTV").GetValue(item, null);
                    worksheet.Cells[row, 7].Value = item.GetType().GetProperty("LoaiTA").GetValue(item, null);
                    worksheet.Cells[row, 8].Value = item.GetType().GetProperty("PhanBo").GetValue(item, null);
                    worksheet.Cells[row, 9].Value = item.GetType().GetProperty("KinhDo").GetValue(item, null);
                    worksheet.Cells[row, 10].Value = item.GetType().GetProperty("ViDo").GetValue(item, null);
                    row++;
                }
                using (MemoryStream memoryStream = new MemoryStream())
                {
                    excelPackage.SaveAs(memoryStream);
                    // Đặt tên file và trả về nó như là một FileResult
                    return File(memoryStream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", $"{fileName}.xlsx");
                }
            }
        }
        [HttpGet]
        public async Task<IActionResult> ManageImage(int idLoai, int PageIndex = 1, int PageSize = 8)
        {
            var listLoai = await _manageSpecies.getAllItem();
            ViewBag.Loai = listLoai.Select(x => new SelectListItem()
            {
                Text = x.Name,
                Value = x.Id.ToString(),
                Selected=x.Id==idLoai,
            });
            var newList = await _manageSpeciesNationPark.getImage();
            if (idLoai > 0)
            {
                newList = newList.Where(x => x.IdLoai == idLoai).ToList();
            }
            var totalCount = newList.Count;
            newList = newList.Skip((PageIndex - 1) * PageSize).Take(PageSize).ToList();
            var pageResult = new PageResult<ImageModel>
            {
                TotalRecords = totalCount,
                Items = newList,
                PageIndex = PageIndex,
                PageSize = PageSize,
            };
            return View(pageResult);
        }
    }
}
