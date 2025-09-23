// Holder styr på dine entities (Student, Course, Enrollment) og laver dem om til tabeller i databasen
// Bruges til at lave migrationer og opdatere databasen

using Microsoft.EntityFrameworkCore;

namespace compulsory1.Models
{
    public class AppDbContext : DbContext
    {
        public DbSet<Student> Students { get; set; }
        public DbSet<Course> Courses { get; set; }
        public DbSet<Enrollment> Enrollments { get; set; }

        // Simpel opsætning til Console App – ingen DI nødvendig
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseSqlite("Data Source=students.db");
            }
        }
    }
}