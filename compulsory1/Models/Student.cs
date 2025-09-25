namespace compulsory1.Models
{
    public class Student
    {
        public int Id { get; set; }                  
        public string FirstName { get; set; } = "";  
        public string? MiddleName { get; set; }
        public string LastName  { get; set; 
        public string Email     { get; set; } = "";
        public DateTime EnrollmentDate { get; set; }
        public string Gender { get; set; } = "";

        // Navigation property for related enrollments (FK relationship)
        public ICollection<Enrollment> Enrollments { get; set; } = new List<Enrollment>();
    

    }
}