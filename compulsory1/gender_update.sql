BEGIN TRANSACTION;
ALTER TABLE "Students" ADD "Gender" TEXT NOT NULL DEFAULT '';

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20250923082349_AddGenderToStudent', '9.0.9');

COMMIT;

