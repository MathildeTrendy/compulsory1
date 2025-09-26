# Student Management – Database Migrations (Compulsory1)

Dette projekt demonstrerer to forskellige tilgange til database­migrationer i **Entity Framework Core**:  
1. Change-based (Code-First)  
2. State-based  

Formålet er at illustrere styrker og svagheder ved de to metoder og give en praktisk reference til, hvordan man kan anvende dem i .NET / EF Core sammenhæng.

---

## Baggrund og motivation

I mange softwareprojekter med databaser er migrations et centralt spørgsmål: hvordan bringer vi databasen i sync med modellen (domain classes), når vi udvikler videre over tid?  

De to traditionelle tilgange:

- **Change-based (Code-First migrations)**: Man skriver kode, ændrer modellen, genererer en migration pr. ændring og anvender disse trinvis.  
- **State-based**: Man genererer et fuldt SQL-script, der transformerer databasen fra den aktuelle tilstand til den ønskede modellestand; man behøver ikke bevare hele historikken i migrationsfiler.

Dette projekt viser begge tilgange i én kontekst (et "student management"-system med entiteter som `Student`, `Course`, `Enrollment`), og illustrerer, hvornår man bør vælge den ene eller den anden.

---

## Arkitektur og struktur

Projektets mappe­struktur (relevant del) ser omtrent sådan ud:

```
/compulsory1
 ├── state-based/ sqlite
 ├── compulsory1/ (den primære .NET-projektmappe)
 ├── artifacts/ ef
 ├── .gitignore
 ├── README.md
 ├── README_STATE.md
 ├── README_EF.md
```

Forklaring:

- `compulsory1/` — hovedprojektet med EF Core, entiteter, kontekst og migrations ­ (Code-First)  
- `state-based/ sqlite` — mappe med det SQL-script eller databasefiler, der bruges i state-based tilgangen  
- `artifacts/ ef` — mappe med artefakter genereret af EF, fx migrationsfiler, snapshots mv.  
- `README_STATE.md` — specifik dokumentation for state-based-tilgangen  
- `README_EF.md` — dokumentation for EF / change-based tilgangen  

I `compulsory1/` findes typisk:

- Modelklasser (fx `Student`, `Course`, `Enrollment`)  
- `DbContext` (f.eks. `StudentContext` eller lignende)  
- Konfiguration af EF Core  
- Migrationsmapper genereret af EF  
- Kode til seed-data eller initialisering  

---

## Installation og opsætning

Følgende trin beskriver, hvordan du sætter projektet op lokalt og afprøver de forskellige migrationsmetoder.

### Forudsætninger

- .NET SDK (fx .NET 6 eller nyere)  
- EF Core CLI-værktøjer  
- SQLite (eller en anden database, hvis du ønsker at skifte)  

### Pakkeinstallation

Kør i projektmappen:

```bash
dotnet add package Microsoft.EntityFrameworkCore
dotnet add package Microsoft.EntityFrameworkCore.Design
dotnet add package Microsoft.EntityFrameworkCore.Sqlite
```

Du kan verificere installerede pakker med:

```bash
dotnet list package
```

---

## Brug og eksempler

### Change-based migrations

1. Opret den første migration:

   ```bash
   dotnet ef migrations add InitialCreate
   ```

2. Anvend migrationen til databasen:

   ```bash
   dotnet ef database update
   ```

3. Ændringer i modellen:

   ```bash
   // Tilføj fx en ny property i Student-klassen
   dotnet ef migrations add AddGenderToStudent
   dotnet ef database update
   ```

---

### State-based migrations

1. Generer et SQL-script:

   ```bash
   dotnet ef migrations script -o update.sql
   ```

2. Kør `update.sql` mod databasen via dit foretrukne databaseværktøj.  

Dette script indeholder den fulde ændring fra den nuværende database til den ønskede modellestand.

---

## Fordele og ulemper

### ✅ Change-based (Code-First)

**Fordele:**
- Historik over alle ændringer  
- Mulighed for rollback  
- God til større projekter med flere udviklere  

**Ulemper:**
- Mange migrationsfiler over tid  
- Potentielle merge-konflikter  

### ✅ State-based

**Fordele:**
- Ét samlet script til distribution  
- Ingen afhængighed af migrationshistorik  
- Simpelt at deploye  

**Ulemper:**
- Ingen detaljeret historik  
- Svært at rulle specifikke ændringer tilbage  

---

## Projektstatus og konklusion

Dette projekt er et undervisnings- og demonstrationsprojekt, der viser to migrationsstrategier i EF Core.  

- Change-based giver kontrol og historik.  
- State-based giver enkelhed og hurtig deployment.  

Begge tilgange har deres berettigelse afhængig af projektets størrelse og behov.

---
