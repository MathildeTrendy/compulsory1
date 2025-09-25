namespace compulsory1.Models
{
    public class Enrollment
    {
        public int Id { get; set; }

        // FKs (krævede)
        public int StudentId { get; set; }
        public int CourseId  { get; set; }

        // Grade i V1–V4 (valgfrí -> non-destructive)
        public string? Grade { get; set; }

        // Navigationer (krævede refs)
        public Student Student { get; set; } = null!;
        public Course  Course  { get; set; } = null!;
    }
}