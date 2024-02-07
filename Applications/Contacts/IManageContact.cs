using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.Contacts.Dtos;
using DongThucVatQuangTri.Applications.NewsItem.Dtos.NewsDtos;
using DongThucVatQuangTri.Applications.Tours.Dtos;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using DongThucVatQuangTri.Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DongThucVatQuangTri.Applications.Contacts
{
    public interface IManageContact
    {
        Task<List<Contact>> GetAll();
        public Task<ApiResult<PageResult<ContactViewModels>>> GetAlllPaging(GetContactPaging request);
        Task<int> Create(CreateContactRequest request);
        Task<int> Delete(int CategoryId);
        Task<Contact> GetById(int categoryId);
        public Task<int> updateContact(UpdateContactRequest request);
        public Task<int> ChangeStatus(ChangeStatusRequest request);
    }
}
