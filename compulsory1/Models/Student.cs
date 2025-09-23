namespace compulsory1.Models
{
    public class Student
    {
        public int Id { get; set; }                  // PK
        public string FirstName { get; set; } = "";  // brugt i opgaven senere
        public string LastName  { get; set; } = "";
        public string Email     { get; set; } = "";
        public DateTime EnrollmentDate { get; set; }
    }
}