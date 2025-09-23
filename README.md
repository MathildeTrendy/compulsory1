# Student Management – Database Migrations

Dette projekt demonstrerer to forskellige tilgange til database-migrationer i Entity Framework Core: **Change-based (Code-First)** og **State-based**.

---

## 📦 Installation af nødvendige pakker

For at komme i gang installerede vi Entity Framework Core og SQLite (vi bruger SQLite i dette projekt, men SqlServer kunne også anvendes):

```bash
dotnet add package Microsoft.EntityFrameworkCore
dotnet add package Microsoft.EntityFrameworkCore.Design
dotnet add package Microsoft.EntityFrameworkCore.Sqlite
```

👉 Du kan se alle installerede pakker i projektet ved at køre:

```bash
dotnet list package
```

---

## 🔹 Change-based migration (Code-First med EF Core)

Når vi arbejder **change-based**, betyder det, at vi laver små trin for hver ændring i vores datamodel. EF Core opretter en migrationsfil, som beskriver præcis hvilke ændringer, der skal laves i databasen.

### Sådan fungerer det:

1. **Opret første migration**

   ```bash
   dotnet ef migrations add InitialCreate
   ```

   Dette laver en migrationsmappe med:

   - En migrationsfil (`InitialCreate`), der indeholder SQL til at oprette tabellerne (`Students`, `Courses`, `Enrollments`).
   - En `ModelSnapshot`, der holder styr på den aktuelle modeltilstand.

2. **Opdater databasen**

   ```bash
   dotnet ef database update
   ```

   Dette kører migrationsfilen og opretter databasen (her `students.db`).

3. **Foretag ændringer i modellen**  
   Hvis vi fx tilføjer feltet `Gender` til `Student`, laver vi en ny migration:

   ```bash
   dotnet ef migrations add AddGenderToStudent
   dotnet ef database update
   ```

   Nu er databasen opdateret med en ny kolonne `Gender` i tabellen `Students`.

### Fordele / Ulemper

- ✅ Gemmer hele historikken af ændringer → nemt at rulle tilbage eller forstå udviklingen.
- ❌ Kan resultere i mange migrationsfiler over tid.

---

## 🔹 State-based migration (Model vs. Database)

Ved state-based migration fokuserer man ikke på historikken af ændringer, men kun på forskellen mellem **den aktuelle database** og **den ønskede model**.

### Sådan fungerer det:

1. Generér et SQL-script direkte ud fra modellen:

   ```bash
   dotnet ef migrations script -o update.sql
   ```

2. Dette laver en fil `update.sql`, som indeholder hele den nødvendige SQL til at bringe databasen i sync med den nyeste model.
   - Hvis man deler databasen med andre, kan de bare køre `update.sql`.
   - De behøver ikke alle tidligere migrations – kun scriptet, der repræsenterer den endelige tilstand.

### Fordele / Ulemper

- ✅ Hurtig måde at bringe en database up-to-date.
- ❌ Mangler detaljeret historik, hvilket gør det svært at rulle præcise ændringer tilbage.

---

## 📝 Konklusion

- **Change-based** bruges til dagligt udviklingsarbejde, hvor man vil bevare en log af alle ændringer.
- **State-based** kan bruges til at generere en endelig version af databasen hurtigt, fx til deployment.
