CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" TEXT NOT NULL CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY,
    "ProductVersion" TEXT NOT NULL
);

BEGIN TRANSACTION;
CREATE TABLE "Courses" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_Courses" PRIMARY KEY AUTOINCREMENT,
    "Title" TEXT NOT NULL,
    "Credits" INTEGER NOT NULL
);

CREATE TABLE "Students" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_Students" PRIMARY KEY AUTOINCREMENT,
    "FirstName" TEXT NOT NULL,
    "LastName" TEXT NOT NULL,
    "Email" TEXT NOT NULL,
    "EnrollmentDate" TEXT NOT NULL
);

CREATE TABLE "Enrollments" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_Enrollments" PRIMARY KEY AUTOINCREMENT,
    "StudentId" INTEGER NOT NULL,
    "CourseId" INTEGER NOT NULL,
    "Grade" INTEGER NOT NULL,
    CONSTRAINT "FK_Enrollments_Courses_CourseId" FOREIGN KEY ("CourseId") REFERENCES "Courses" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_Enrollments_Students_StudentId" FOREIGN KEY ("StudentId") REFERENCES "Students" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_Enrollments_CourseId" ON "Enrollments" ("CourseId");

CREATE INDEX "IX_Enrollments_StudentId" ON "Enrollments" ("StudentId");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20250923081923_InitialCreate', '9.0.9');

ALTER TABLE "Students" ADD "Gender" TEXT NOT NULL DEFAULT '';

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20250923082349_AddGenderToStudent', '9.0.9');

ALTER TABLE "Students" ADD "DateOfBirth" TEXT NULL;

ALTER TABLE "Students" ADD "MiddleName" TEXT NULL;

CREATE TABLE "ef_temp_Students" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_Students" PRIMARY KEY AUTOINCREMENT,
    "DateOfBirth" TEXT NULL,
    "Email" TEXT NOT NULL,
    "EnrollmentDate" TEXT NOT NULL,
    "FirstName" TEXT NOT NULL,
    "Gender" TEXT NULL,
    "LastName" TEXT NOT NULL,
    "MiddleName" TEXT NULL
);

INSERT INTO "ef_temp_Students" ("Id", "DateOfBirth", "Email", "EnrollmentDate", "FirstName", "Gender", "LastName", "MiddleName")
SELECT "Id", "DateOfBirth", "Email", "EnrollmentDate", "FirstName", "Gender", "LastName", "MiddleName"
FROM "Students";

CREATE TABLE "ef_temp_Enrollments" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_Enrollments" PRIMARY KEY AUTOINCREMENT,
    "CourseId" INTEGER NOT NULL,
    "Grade" TEXT NULL,
    "StudentId" INTEGER NOT NULL,
    CONSTRAINT "FK_Enrollments_Courses_CourseId" FOREIGN KEY ("CourseId") REFERENCES "Courses" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_Enrollments_Students_StudentId" FOREIGN KEY ("StudentId") REFERENCES "Students" ("Id") ON DELETE CASCADE
);

INSERT INTO "ef_temp_Enrollments" ("Id", "CourseId", "Grade", "StudentId")
SELECT "Id", "CourseId", "Grade", "StudentId"
FROM "Enrollments";

COMMIT;

PRAGMA foreign_keys = 0;

BEGIN TRANSACTION;
DROP TABLE "Students";

ALTER TABLE "ef_temp_Students" RENAME TO "Students";

DROP TABLE "Enrollments";

ALTER TABLE "ef_temp_Enrollments" RENAME TO "Enrollments";

COMMIT;

PRAGMA foreign_keys = 1;

BEGIN TRANSACTION;
CREATE INDEX "IX_Enrollments_CourseId" ON "Enrollments" ("CourseId");

CREATE INDEX "IX_Enrollments_StudentId" ON "Enrollments" ("StudentId");

COMMIT;

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20250925111159_V2_AddMiddleNameToStudent', '9.0.9');

BEGIN TRANSACTION;
INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20250925112810_V3_AddDateOfBirthToStudent', '9.0.9');

ALTER TABLE "Courses" ADD "InstructorId" INTEGER NULL;

CREATE TABLE "Instructors" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_Instructors" PRIMARY KEY AUTOINCREMENT,
    "FirstName" TEXT NOT NULL,
    "LastName" TEXT NOT NULL,
    "Email" TEXT NOT NULL,
    "HireDate" TEXT NOT NULL
);

CREATE INDEX "IX_Courses_InstructorId" ON "Courses" ("InstructorId");

CREATE TABLE "ef_temp_Courses" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_Courses" PRIMARY KEY AUTOINCREMENT,
    "Credits" INTEGER NOT NULL,
    "InstructorId" INTEGER NULL,
    "Title" TEXT NOT NULL,
    CONSTRAINT "FK_Courses_Instructors_InstructorId" FOREIGN KEY ("InstructorId") REFERENCES "Instructors" ("Id")
);

INSERT INTO "ef_temp_Courses" ("Id", "Credits", "InstructorId", "Title")
SELECT "Id", "Credits", "InstructorId", "Title"
FROM "Courses";

COMMIT;

PRAGMA foreign_keys = 0;

BEGIN TRANSACTION;
DROP TABLE "Courses";

ALTER TABLE "ef_temp_Courses" RENAME TO "Courses";

COMMIT;

PRAGMA foreign_keys = 1;

BEGIN TRANSACTION;
CREATE INDEX "IX_Courses_InstructorId" ON "Courses" ("InstructorId");

COMMIT;

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20250925114736_V4_AddInstructorAndCourseFk', '9.0.9');

BEGIN TRANSACTION;
ALTER TABLE "Enrollments" RENAME COLUMN "Grade" TO "FinalGrade";

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20250925114949_V5_RenameGradeToFinalGrade', '9.0.9');

CREATE TABLE "Departments" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_Departments" PRIMARY KEY AUTOINCREMENT,
    "Name" TEXT NOT NULL,
    "Budget" TEXT NOT NULL,
    "StartDate" TEXT NOT NULL,
    "DepartmentHeadId" INTEGER NULL,
    CONSTRAINT "FK_Departments_Instructors_DepartmentHeadId" FOREIGN KEY ("DepartmentHeadId") REFERENCES "Instructors" ("Id") ON DELETE SET NULL
);

CREATE UNIQUE INDEX "IX_Departments_DepartmentHeadId" ON "Departments" ("DepartmentHeadId");

CREATE TABLE "ef_temp_Courses" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_Courses" PRIMARY KEY AUTOINCREMENT,
    "Credits" INTEGER NOT NULL,
    "InstructorId" INTEGER NULL,
    "Title" TEXT NOT NULL,
    CONSTRAINT "FK_Courses_Instructors_InstructorId" FOREIGN KEY ("InstructorId") REFERENCES "Instructors" ("Id") ON DELETE SET NULL
);

INSERT INTO "ef_temp_Courses" ("Id", "Credits", "InstructorId", "Title")
SELECT "Id", "Credits", "InstructorId", "Title"
FROM "Courses";

COMMIT;

PRAGMA foreign_keys = 0;

BEGIN TRANSACTION;
DROP TABLE "Courses";

ALTER TABLE "ef_temp_Courses" RENAME TO "Courses";

COMMIT;

PRAGMA foreign_keys = 1;

BEGIN TRANSACTION;
CREATE INDEX "IX_Courses_InstructorId" ON "Courses" ("InstructorId");

COMMIT;

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20250926093600_V6_AddDepartmentWithHead', '9.0.9');

BEGIN TRANSACTION;
DROP INDEX "IX_Departments_DepartmentHeadId";

CREATE INDEX "IX_Departments_DepartmentHeadId" ON "Departments" ("DepartmentHeadId");

CREATE TABLE "ef_temp_Courses" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_Courses" PRIMARY KEY AUTOINCREMENT,
    "Credits" TEXT NOT NULL,
    "InstructorId" INTEGER NULL,
    "Title" TEXT NOT NULL,
    CONSTRAINT "FK_Courses_Instructors_InstructorId" FOREIGN KEY ("InstructorId") REFERENCES "Instructors" ("Id") ON DELETE SET NULL
);

INSERT INTO "ef_temp_Courses" ("Id", "Credits", "InstructorId", "Title")
SELECT "Id", "Credits", "InstructorId", "Title"
FROM "Courses";

COMMIT;

PRAGMA foreign_keys = 0;

BEGIN TRANSACTION;
DROP TABLE "Courses";

ALTER TABLE "ef_temp_Courses" RENAME TO "Courses";

COMMIT;

PRAGMA foreign_keys = 1;

BEGIN TRANSACTION;
CREATE INDEX "IX_Courses_InstructorId" ON "Courses" ("InstructorId");

COMMIT;

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20250926094344_V7_ChangeCreditsToDecimal', '9.0.9');

