using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace DongThucVatQuangTri.Datas.Migrations
{
    public partial class updateRole2 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<DateTime>(
                name: "UpdateAt",
                table: "Role",
                type: "datetime2",
                nullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "UpdateAt",
                table: "Role");
        }
    }
}
