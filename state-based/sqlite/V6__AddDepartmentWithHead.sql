CREATE TABLE IF NOT EXISTS Departments (
  Id INTEGER PRIMARY KEY AUTOINCREMENT,
  Name   TEXT NOT NULL,
  Budget REAL NOT NULL,
  StartDate TEXT NOT NULL,
  DepartmentHeadId INTEGER NULL,
  FOREIGN KEY (DepartmentHeadId) REFERENCES Instructors(Id) ON DELETE SET NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS UX_Departments_DepartmentHeadId
  ON Departments(DepartmentHeadId);
