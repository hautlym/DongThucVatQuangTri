using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DongThucVatQuangTri.Applications.Contacts.Dtos
{
    public class CreateContactRequest
    {
        public string Name { get; set; }
        public string Email { get; set; }
        public string NumberPhone { get; set; }
        public string Message { get; set; }
        public string? typeNationPark { get; set; }
    }
}
