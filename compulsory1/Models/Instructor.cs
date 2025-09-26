using System.Collections.Generic;

namespace compulsory1.Models;

public class Instructor
{
    public int Id { get; set; }
    public string FirstName { get; set; } = null!;
    public string LastName  { get; set; } = null!;
    public string Email     { get; set; } = null!;
    public DateTime HireDate { get; set; }
    public ICollection<Course> Courses { get; set; } = new List<Course>();
   
}