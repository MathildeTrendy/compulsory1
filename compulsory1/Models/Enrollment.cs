namespace compulsory1.Models
{
    public class Enrollment
    {
        public int Id { get; set; }                  
        public int StudentId { get; set; }  
        public int CourseId  { get; set; }
        public int Grade     { get; set; }

        public Student? Student { get; set; }  // Navigation property (FK relationship)
        public Course? Course   { get; set; }  // Navigation property (FK relationship)

    }
}