PRAGMA foreign_keys=OFF;
BEGIN;

CREATE TABLE IF NOT EXISTS Instructors (
  Id INTEGER PRIMARY KEY AUTOINCREMENT,
  FirstName TEXT NOT NULL,
  LastName  TEXT NOT NULL,
  Email     TEXT NOT NULL,
  HireDate  TEXT NOT NULL
);

CREATE TABLE Courses_new (
  Id INTEGER PRIMARY KEY AUTOINCREMENT,
  Title  TEXT NOT NULL,
  Credits INTEGER NOT NULL,
  InstructorId INTEGER NULL,
  FOREIGN KEY (InstructorId) REFERENCES Instructors(Id) ON DELETE SET NULL
);

INSERT INTO Courses_new(Id, Title, Credits, InstructorId)
SELECT Id, Title, Credits, NULL FROM Courses;

DROP TABLE Courses;
ALTER TABLE Courses_new RENAME TO Courses;

COMMIT;
PRAGMA foreign_keys=ON;
