using System.ComponentModel.DataAnnotations;

namespace DongThucVatQuangTri.Applications.GroupUsers.Dtos
{
    public class UpdateGroupUserRequest
    {
        public int Id { get; set; }
        [Required(ErrorMessage = "Vui lòng điền tên")]

        public string Name { get; set; }
    }
}
