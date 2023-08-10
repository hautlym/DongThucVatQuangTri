namespace DongThucVatQuangTri.Applications.UserManage.Dtos
{
    public class UpdatePasswordRequest
    {
        public Guid Id { get; set; }
        public string CurrentPassword { get; set; }
        public string NewPassword { get; set; }
        public string? ConfirmPassword { get; set; }
    }
}
