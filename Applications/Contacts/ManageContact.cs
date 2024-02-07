
using DongThucVatQuangTri.Applications.Banners.Dtos;
using DongThucVatQuangTri.Applications.Common;
using DongThucVatQuangTri.Applications.Contacts.Dtos;
using DongThucVatQuangTri.Applications.Enums;
using DongThucVatQuangTri.Applications.NewsItem.Dtos.NewsDtos;
using DongThucVatQuangTri.Applications.Tours.Dtos;
using DongThucVatQuangTri.Applications.UserManage.Dtos;
using DongThucVatQuangTri.Models.EF;
using DongThucVatQuangTri.Models.Entities;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DongThucVatQuangTri.Applications.Contacts
{
    public class ManageContact : IManageContact
    {
        private readonly DongThucVatContext _context;
        public ManageContact(DongThucVatContext context)
        {
            _context = context;
        }

        public async Task<int> ChangeStatus(ChangeStatusRequest request)
        {
            var news = await _context.contacts.Where(x => x.Id == request.Id).FirstOrDefaultAsync();
            if (news == null)
                return -1;
            news.status = request.status.ToString();
            _context.contacts.Update(news);
            return await _context.SaveChangesAsync();
        }

        public async Task<int> Create(CreateContactRequest request)
        {
            var contact = new Contact()
            {
                Email = request.Email,
                Message = request.Message,
                Name = request.Name,
                NumberPhone = request.NumberPhone,
                CreateAt = DateTime.Now,
                status = statusContact.NotRespond.ToString(),
                typeNationPark = request.typeNationPark,
            };
            _context.contacts.Add(contact);
            await _context.SaveChangesAsync();
            return contact.Id;
        }

        public async Task<int> Delete(int ContactId)
        {
            var contact = await _context.contacts.Where(x => x.Id == ContactId).FirstOrDefaultAsync();
            if (contact == null) return -1;
            _context.contacts.Remove(contact);
            return await _context.SaveChangesAsync();
        }

        public async Task<List<Contact>> GetAll()
        {
            var data = await _context.contacts.ToListAsync();
            return data;
        }

        public async Task<ApiResult<PageResult<ContactViewModels>>> GetAlllPaging(GetContactPaging request)
        {
            var query = from b in _context.contacts
                        select new { b };
            var list = query.ToList();
            if (!string.IsNullOrEmpty(request.Keyword))
            {
                query = query.Where(x => x.b.Name.Contains(request.Keyword));
            }
            if (!string.IsNullOrEmpty(request.typeNationPark))
            {
                query = query.Where(x => x.b.typeNationPark == request.typeNationPark);
            }
            int totalRow = await query.CountAsync();
            var data = await query.Skip((request.PageIndex - 1) * request.PageSize).Take(request.PageSize)
                .Select(request => new ContactViewModels()
                {
                    Id = request.b.Id,
                    Name = request.b.Name,
                    typeNationPark = request.b.typeNationPark,
                    Note = request.b.Note,
                    CreateAt = request.b.CreateAt,
                    ResponseAt =request.b.ResponseAt,
                    Message = request.b.Message,
                    Email = request.b.Email,
                    NumberPhone = request.b.NumberPhone,
                    status = request.b.status

                }).ToListAsync();
            var pageResult = new PageResult<ContactViewModels>
            {
                TotalRecords = totalRow,
                Items = data,
                PageIndex = request.PageIndex,
                PageSize = request.PageSize,
            };
            return new ApiSuccessResult<PageResult<ContactViewModels>>(pageResult);
        }

        public async Task<Contact> GetById(int ContactId)
        {
            var categories = await _context.contacts.Where(x => x.Id == ContactId).FirstOrDefaultAsync();

            if (categories != null)
            {
                return categories;
            }
            else
            {
                return null;
            }
        }

        public async Task<int> updateContact(UpdateContactRequest request)
        {
            var contact = await _context.contacts.Where(x => x.Id ==request.Id).FirstOrDefaultAsync();
            if (contact == null)
            {
                return -1;
            }
            contact.Note = request.Note;
            contact.status = request.status;
            _context.contacts.Update(contact);
            return await _context.SaveChangesAsync();
        }
    }
}
