namespace compulsory1.Models
{
    public class Student
    {
        public int Id { get; set; }

        // krævede felter
        public string FirstName { get; set; } = null!;
        public string LastName  { get; set; } = null!;
        public string Email     { get; set; } = null!;
        public DateTime EnrollmentDate { get; set; }

        // valgfrie felter (V2, V3, din egen Gender)
        public string? MiddleName { get; set; }         // V2
        public DateTime? DateOfBirth { get; set; }      // V3 (kommer senere)
        public string? Gender { get; set; }             // ekstra felt

        public ICollection<Enrollment> Enrollments { get; set; } = new List<Enrollment>();
    }
}