using System.ComponentModel.DataAnnotations;

namespace DongThucVatQuangTri.Applications.GroupUsers.Dtos
{
    public class CreateGroupUserRequest
    {
        [Required(ErrorMessage = "Vui lòng điền tên")]

        public string Name { get; set; }
    }
}
