using DongThucVatQuangTri.Models.EF;
using System.Net.WebSockets;

namespace DongThucVatQuangTri.Applications.Animals
{
    public class testAnimal : ITestAnimal
    {
        private readonly DongThucVatContext _context;
        public testAnimal(DongThucVatContext context)
        {
            _context = context;
        }
        public int getAnimal()
        {
            var listItem = _context.Banner.ToList();
            var count = listItem.Count;
            return count;
        }
    }
}
