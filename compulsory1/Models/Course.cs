namespace compulsory1.Models
{
    public class Course
    {
        public int Id { get; set; }
        public string Title { get; set; } = null!;
        public int Credits { get; set; } // V7: skiftes til decimal(5,2)

        // V4: FK til Instructor (nullable = non-destructive)
        public int? InstructorId { get; set; }
        public Instructor? Instructor { get; set; }

        public ICollection<Enrollment> Enrollments { get; set; } = new List<Enrollment>();
    }
}