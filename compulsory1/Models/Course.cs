namespace compulsory1.Models
{
    public class Course
    {
        public int Id { get; set; }                  
        public string Title  { get; set; } = "";
        public int Credits     { get; set; }

        // Navigation property (FK relationship)
        public ICollection<Enrollment> Enrollments { get; set; } = new List<Enrollment>(); 

    }
}