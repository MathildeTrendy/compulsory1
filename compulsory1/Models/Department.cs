namespace compulsory1.Models;

public class Department
{
    public int Id { get; set; }
    public string Name { get; set; } = null!;
    public decimal Budget { get; set; }
    public DateTime StartDate { get; set; }

    // FK til Instructor (nullable = non-destructive)
    public int? DepartmentHeadId { get; set; }
    public Instructor? DepartmentHead { get; set; }
}