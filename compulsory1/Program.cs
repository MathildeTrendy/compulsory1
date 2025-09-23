using compulsory1.Models;
using Microsoft.EntityFrameworkCore;

using var db = new AppDbContext();
Console.WriteLine("Applying migrations…");
db.Database.Migrate();    // opretter DB + kører migrationer
Console.WriteLine("Done. DB is ready.");