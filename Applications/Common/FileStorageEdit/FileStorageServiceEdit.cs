using Microsoft.AspNetCore.Hosting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DongThucVatQuangTri.Applications.Common.FileStorageEdit
{
    public class FileStorageServiceEdit : IStorageServiceEdit
    {
        private readonly string _userContentFolder;

        public FileStorageServiceEdit(IWebHostEnvironment webHostEnvironment)
        {
            _userContentFolder = Path.Combine(webHostEnvironment.WebRootPath);
        }
        public async Task DeleteFileAsync(string folder, string fileName)
        {
            var filePath = Path.Combine(_userContentFolder, folder, fileName);
            if (File.Exists(filePath))
            {
                await Task.Run(() => File.Delete(filePath));
            }
        }

        public string GetFileUrl(string folder, string fileName)
        {
            return $"/{folder}/{fileName}";
        }

        public async Task SaveFileAsync(Stream mediaBinaryStream, string folder, string fileName)
        {
            var checkFolder = Directory.Exists(Path.Combine(_userContentFolder, folder));
            if (!checkFolder)
            {
                Directory.CreateDirectory(Path.Combine(_userContentFolder, folder));
            }
            var filePath = Path.Combine(_userContentFolder, folder, fileName);
            using var output = new FileStream(filePath, FileMode.Create);
            await mediaBinaryStream.CopyToAsync(output);
        }
    }
}
