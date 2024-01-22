using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace DongThucVatQuangTri.Datas.Migrations
{
    public partial class addRoleNewsTours : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "TypeNationPark",
                table: "tour",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "TypeNationPark",
                schema: "dongthucvat",
                table: "news_cat",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "TypeNationPark",
                schema: "dongthucvat",
                table: "news",
                type: "nvarchar(max)",
                nullable: true);

 
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "TypeNationPark",
                table: "tour");

            migrationBuilder.DropColumn(
                name: "TypeNationPark",
                schema: "dongthucvat",
                table: "news_cat");

            migrationBuilder.DropColumn(
                name: "TypeNationPark",
                schema: "dongthucvat",
                table: "news");

        }
    }
}
