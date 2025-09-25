namespace compulsory1.Models
{
    public class Course
    {
        public int Id { get; set; }
        public string Title  { get; set; } = null!;

        // V7 kommer senere – start med int (kravet siger du først ændrer i V7)
        public int Credits { get; set; }

        // Navigation
        public ICollection<Enrollment> Enrollments { get; set; } = new List<Enrollment>();
    }
}