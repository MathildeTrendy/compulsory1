PRAGMA foreign_keys=OFF;
BEGIN;

CREATE TABLE Courses_new (
  Id INTEGER PRIMARY KEY AUTOINCREMENT,
  Title  TEXT NOT NULL,
  Credits REAL NOT NULL CHECK (Credits >= 0.00 AND Credits <= 999.99),
  InstructorId INTEGER NULL,
  FOREIGN KEY (InstructorId) REFERENCES Instructors(Id) ON DELETE SET NULL
);

INSERT INTO Courses_new(Id, Title, Credits, InstructorId)
SELECT Id, CAST(Credits AS REAL), InstructorId FROM Courses;

DROP TABLE Courses;
ALTER TABLE Courses_new RENAME TO Courses;

COMMIT;
PRAGMA foreign_keys=ON;
