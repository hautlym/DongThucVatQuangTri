using System.Net.Http.Headers;

namespace DongThucVatQuangTri.Applications.Common
{
    public class ManageFile : IManageFile
    {
        private readonly IStorageService _storageService;
        public ManageFile(IStorageService storageService)
        {
            _storageService = storageService;
        }

        public async Task<string> DeleteFile(string fileName )
        {
            await _storageService.DeleteFileAsync(fileName);
            return fileName;
        }

        public async Task<string> SaveFile(IFormFile file)
        {

            var originalFileName = ContentDispositionHeaderValue.Parse(file.ContentDisposition).FileName.Trim('"');
            var fileName = $"{Guid.NewGuid()}{Path.GetExtension(originalFileName)}";
            await _storageService.SaveFileAsync(file.OpenReadStream(), fileName);
            return fileName;
        }

        
    }
}
