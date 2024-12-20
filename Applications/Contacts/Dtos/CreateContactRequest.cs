using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DongThucVatQuangTri.Applications.Contacts.Dtos
{
    public class CreateContactRequest
    {
        [Required(ErrorMessage = "Vui lòng điền tên")]

        public string Name { get; set; }

        [Required(ErrorMessage = "Vui lòng điền email")]
        public string Email { get; set; }

        [Required(ErrorMessage = "Vui lòng điền số điện thoại")]
        public string NumberPhone { get; set; }

        [Required(ErrorMessage = "Vui lòng điền nội dung")]
        public string Message { get; set; }
        public string? typeNationPark { get; set; }
    }
}
