namespace DongThucVatQuangTri.Applications.UserManage.Dtos
{
    public class AdminUpdatePasswordRequest
    {
        public Guid Id { get; set; }
        public string NewPassword { get; set; }
        public string ConfirmPassword { get; set; }
    }
}
