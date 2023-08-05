using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;

namespace DongThucVatQuangTri.Models.EF
{
    public class DongThucVatContextFactory : IDesignTimeDbContextFactory<DongThucVatContext>
    {
        public DongThucVatContext CreateDbContext(string[] args)
        {
            IConfigurationRoot configuration = new ConfigurationBuilder()
               .SetBasePath(Directory.GetCurrentDirectory())
               .AddJsonFile("appsettings.json")
               .Build();
            var optionBuilder = new DbContextOptionsBuilder<DongThucVatContext>();
            var ConnectionString = configuration.GetConnectionString("DatabaseDongThucVat");
            optionBuilder.UseSqlServer(ConnectionString);
            return new DongThucVatContext(optionBuilder.Options);
        }
    }
}
