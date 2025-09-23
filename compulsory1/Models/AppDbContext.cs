using Microsoft.EntityFrameworkCore;

namespace compulsory1.Models
{
    public class AppDbContext : DbContext
    {
        public DbSet<Student> Students { get; set; } = null!;

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