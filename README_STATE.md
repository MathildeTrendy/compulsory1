# State-based migrations (SQLite)

Her ligger et SQL-script pr. version (V1–V7). Hvert script beskriver den ønskede *sluttilstand* for databasen i den version. Man kører filerne i rækkefølge for at bringe en database up-to-date.

## Kørevejledning (lokalt eksempel – separat test-db)
```bash
rm -f state_students.db
sqlite3 state_students.db < state-based/sqlite/V1__InitialSchema.sql
sqlite3 state_students.db < state-based/sqlite/V2__AddMiddleName.sql
sqlite3 state_students.db < state-based/sqlite/V3__AddDateOfBirth.sql
sqlite3 state_students.db < state-based/sqlite/V4__AddInstructorAndCourseFk.sql
sqlite3 state_students.db < state-based/sqlite/V5__RenameGradeToFinalGrade.sql
sqlite3 state_students.db < state-based/sqlite/V6__AddDepartmentWithHead.sql
sqlite3 state_students.db < state-based/sqlite/V7__ChangeCreditsToDecimal.sql


```
## Noter
- SQLite kræver ofte “table rebuild” for FK-/type-ændringer (derfor `PRAGMA foreign_keys` OFF/ON og transaktioner i V4 og V7).
- Dette er *state-based*-tilgangen. I projektet findes også *change-based* (EF) med migrations og et samlet SQL-artifact under `artifacts/ef/`.
