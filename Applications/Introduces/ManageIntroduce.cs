using DongThucVatQuangTri.Applications.Introduces.Dtos;
using DongThucVatQuangTri.Models.EF;
using Microsoft.EntityFrameworkCore;

namespace DongThucVatQuangTri.Applications.Introduces
{
    public class ManageIntroduce : IManageIntroduce
    {
        private readonly DongThucVatContext _context;
        public ManageIntroduce(DongThucVatContext context)
        {
                _context = context;
        }
        public async Task<List<IntroduceViewModel>> getAll()
        {
            
            var data =await _context.introduce.Select(x => new IntroduceViewModel()
            {
                Id = x.id,
                title = x.title,
                content = x.content,
                typeNationPak = x.typeNationPak,
                UpdateAt = x.UpdateAt,
                UpdateBy =_context.appUsers.Where(y=>y.Id.ToString() == x.UpdateBy).Select(z=>z.FirstName+""+z.LastName).FirstOrDefault(),
            }).ToListAsync();
            return data;
        }

        public async Task<IntroduceViewModel> getById(int Id)
        {
            var data = await _context.introduce.Where(x=>x.id==Id).Select(x => new IntroduceViewModel()
            {
                Id= x.id,
                title = x.title,
                content = x.content,
                typeNationPak = x.typeNationPak,
                UpdateAt = x.UpdateAt,
                UpdateBy = _context.appUsers.Where(y => y.Id.ToString() == x.UpdateBy).Select(z => z.FirstName + "" + z.LastName).FirstOrDefault(),
            }).FirstOrDefaultAsync();
            return data;
        }

        public async Task<int> Update(UpdateIntroduceRequest request)
        {
            
            var intro  =await _context.introduce.Where(x=>x.id==request.id).FirstOrDefaultAsync();
            if(intro==null)
            {
                return -1;
            }
            intro.content = request.content;
            intro.UpdateAt = DateTime.Now;
            intro.UpdateBy = request.UpdateBy;
            _context.introduce.Update(intro);
            return await _context.SaveChangesAsync();
        }
    }
}
