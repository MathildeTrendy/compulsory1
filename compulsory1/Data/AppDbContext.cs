using Microsoft.EntityFrameworkCore;

namespace compulsory1.Models
{
    public class AppDbContext : DbContext
    {
        public DbSet<Student> Students   { get; set; } = null!;
        public DbSet<Course> Courses     { get; set; } = null!;
        public DbSet<Enrollment> Enrollments { get; set; } = null!;
        public DbSet<Instructor> Instructors { get; set; } = null!;
        public DbSet<Department> Departments { get; set; } = null!;

        // Simpel opsætning til Console App – ingen DI nødvendig
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseSqlite("Data Source=students.db");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // V4: Course ↔ Instructor (nullable FK, behold kursus hvis instruktør slettes)
            modelBuilder.Entity<Course>()
                .HasOne(c => c.Instructor)
                .WithMany(i => i.Courses)
                .HasForeignKey(c => c.InstructorId)
                .OnDelete(DeleteBehavior.SetNull);

            // V6: Department ↔ DepartmentHead (Instructor) (nullable FK)
            modelBuilder.Entity<Department>()
                .HasOne(d => d.DepartmentHead)
                .WithMany() 
                .HasForeignKey(d => d.DepartmentHeadId)
                .OnDelete(DeleteBehavior.SetNull);

            modelBuilder.Entity<Course>()
                .Property(c => c.Credits)
                .HasPrecision(5, 2);
        }
    }
}