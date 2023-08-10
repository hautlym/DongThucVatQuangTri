namespace DongThucVatQuangTri.Applications.Common
{
    public interface IManageFile
    {
        public  Task<string> SaveFile(IFormFile file);
    }
}
