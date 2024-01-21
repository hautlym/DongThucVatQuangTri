using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace DongThucVatQuangTri.Datas.Migrations
{
    public partial class editNationPark : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "TypeNationPark",
                schema: "dongthucvat",
                table: "dtv_loaiVqg",
                type: "nvarchar(max)",
                nullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "TypeNationPark",
                schema: "dongthucvat",
                table: "dtv_loaiVqg");
        }
    }
}
