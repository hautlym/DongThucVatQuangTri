using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace DongThucVatQuangTri.Datas.Migrations
{
    public partial class editLoai : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.EnsureSchema(
                name: "dongthucvat");
            migrationBuilder.CreateTable(
   name: "dtv_loaiVqg",
   schema: "dongthucvat",
   columns: table => new
   {
       id = table.Column<int>(type: "int", nullable: false)
           .Annotation("SqlServer:Identity", "1, 1"),
       IdDtvLoai = table.Column<int>(type: "int", nullable: false),
       ten_khac = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
       dac_diem = table.Column<string>(type: "nvarchar(max)", nullable: false),
       gia_tri_su_dung = table.Column<string>(type: "nvarchar(max)", nullable: false),
       phan_bo = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
       status = table.Column<short>(type: "smallint", nullable: true),
       loai = table.Column<short>(type: "smallint", nullable: true),
       file_dinh_kem = table.Column<string>(type: "nvarchar(max)", nullable: false),
       nguon_tai_lieu = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
       created_at = table.Column<DateTime>(type: "datetime", nullable: true),
       created_by = table.Column<string>(type: "nvarchar(max)", nullable: true),
       updated_at = table.Column<DateTime>(type: "datetime", nullable: true),
       updated_by = table.Column<string>(type: "nvarchar(max)", nullable: true)
   },
   constraints: table =>
   {
       table.PrimaryKey("PK_dtv_lopVqg", x => x.id);
   });


        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {

        }
    }
}
