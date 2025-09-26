using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace compulsory1.Migrations
{
    /// <inheritdoc />
    public partial class V7_ChangeCreditsToDecimal : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Departments_DepartmentHeadId",
                table: "Departments");

            migrationBuilder.AlterColumn<decimal>(
                name: "Credits",
                table: "Courses",
                type: "TEXT",
                precision: 5,
                scale: 2,
                nullable: false,
                oldClrType: typeof(int),
                oldType: "INTEGER");

            migrationBuilder.CreateIndex(
                name: "IX_Departments_DepartmentHeadId",
                table: "Departments",
                column: "DepartmentHeadId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Departments_DepartmentHeadId",
                table: "Departments");

            migrationBuilder.AlterColumn<int>(
                name: "Credits",
                table: "Courses",
                type: "INTEGER",
                nullable: false,
                oldClrType: typeof(decimal),
                oldType: "TEXT",
                oldPrecision: 5,
                oldScale: 2);

            migrationBuilder.CreateIndex(
                name: "IX_Departments_DepartmentHeadId",
                table: "Departments",
                column: "DepartmentHeadId",
                unique: true);
        }
    }
}
