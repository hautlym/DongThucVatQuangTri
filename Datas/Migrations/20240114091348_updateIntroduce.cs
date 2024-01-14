using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace DongThucVatQuangTri.Datas.Migrations
{
    public partial class updateIntroduce : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "typeNationPak",
                table: "introduce",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "typeNationPak",
                table: "introduce");
        }
    }
}
