using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace compulsory1.Migrations
{
    /// <inheritdoc />
    public partial class V5_RenameGradeToFinalGrade : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Grade",
                table: "Enrollments",
                newName: "FinalGrade");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "FinalGrade",
                table: "Enrollments",
                newName: "Grade");
        }
    }
}
