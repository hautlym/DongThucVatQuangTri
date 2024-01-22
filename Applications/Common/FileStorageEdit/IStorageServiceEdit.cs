using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DongThucVatQuangTri.Applications.Common.FileStorageEdit
{
    public interface IStorageServiceEdit
    {
        public string GetFileUrl(string folder, string fileName);
        public Task SaveFileAsync(Stream mediaBinaryStream, string folder, string fileName);
        public Task DeleteFileAsync(string folder, string fileName);

    }
}
