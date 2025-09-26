# Student Management – Database Migrations (Compulsory1)

Dette projekt demonstrerer to forskellige tilgange til database­migrationer i **Entity Framework Core (EF Core)**:  
1. **Change-based (Code-First Migrations)**  
2. **State-based (Full Script Generation)**  

Formålet er at belyse de to metoders forskellige egenskaber i forhold til **database versionering**, **schema evolution** og **kontinuerlig integration/deployment (CI/CD)**.  
Projektet fungerer som en praktisk case i, hvordan man kan håndtere ændringer i databasens schema over tid.

---

## Baggrund og motivation

I moderne softwareudvikling er databasen sjældent statisk. Nye features kræver ændringer i datamodellen, som igen kræver, at **databaseschemaet** (tabeller, kolonner, relationer) justeres.  
En **migration** er et kontrolleret sæt instruktioner, der bringer databasen fra én **versionstilstand** til en anden.

To udbredte tilgange i EF Core er:  

- **Change-based (Code-First)**  
  Her registreres ændringer i modellerne som en sekvens af migrationer. Hver migration beskriver en *differens* (delta) mellem tidligere og ny model.  
  Denne metode understøtter **inkrementel udvikling**, rollback til tidligere versioner og detaljeret versionshistorik.

- **State-based (Script Generation)**  
  Her genereres et fuldt **SQL-script**, der direkte opdaterer databasen fra dens nuværende tilstand til den ønskede sluttilstand.  
  Metoden fokuserer på **idempotente scripts** (kan køres gentagne gange uden bivirkninger) og gør det nemt at distribuere ét samlet script.

I dette projekt anvendes et simpelt **student management system** med entiteter som `Student`, `Course` og `Enrollment` til at demonstrere begge tilgange.

---

## Arkitektur og struktur

Projektets mappe­struktur (uddrag):

```
/compulsory1
 ├── state-based/ sqlite        # SQL-scripts til state-based tilgang
 ├── compulsory1/               # EF Core projekt (models, DbContext, migrations)
 ├── artifacts/ ef              # Genererede migrationsfiler og snapshots
 ├── .gitignore
 ├── README.md                  # Denne dokumentation
```

Indhold i `compulsory1/`:

- **Domain models**: `Student`, `Course`, `Enrollment`  
- **DbContext**: central klasse, der konfigurerer databaseforbindelse og modelmapping  
- **Migrations**: auto-genererede klasser, der beskriver schemaændringer  
- **Model snapshot**: repræsenterer den nuværende modeltilstand (bruges til at sammenligne mod nye ændringer)  
- **Seed-data**: evt. initielle testdata  

---

## Installation og opsætning

### Forudsætninger

- .NET SDK (fx .NET 6/7)  
- EF Core CLI (`dotnet-ef`)  
- SQLite (standard i dette projekt, men nemt at udskifte med SQL Server, PostgreSQL m.fl.)  

### Pakkeinstallation

```bash
dotnet add package Microsoft.EntityFrameworkCore
dotnet add package Microsoft.EntityFrameworkCore.Design
dotnet add package Microsoft.EntityFrameworkCore.Sqlite
```

Bekræft installationen:

```bash
dotnet list package
```

---

## Steps og faglig begrundelse

### Change-based migrations

**Steps udført i projektet:**  
1. Oprettede en **initial migration** baseret på mine domæneklasser:  
   ```bash
   dotnet ef migrations add InitialCreate
   dotnet ef database update
   ```
   Dette genererede både en migrationsklasse og en **ModelSnapshot**, som repræsenterer schemaets tilstand.  
2. Ændrede modellen ved at tilføje en ny property (fx `Gender`) til `Student`.  
   Derefter:  
   ```bash
   dotnet ef migrations add AddGenderToStudent
   dotnet ef database update
   ```
   Dette skabte en inkrementel migration, som kun ændrede databasen med en ekstra kolonne.

**Begrundelse (faglig vurdering):**  
- Change-based tilgangen understøtter **schema evolution** gennem en serie af *deltaer*.  
- Hver migration kan rollbackes, hvilket sikrer **reversibilitet** og **fejltolerance**.  
- Metoden er stærk i teams, hvor **versionskontrol** (Git) håndterer migrationsfilerne, og hvor merge-konflikter skal løses systematisk.  
- Ulempen er **migrationsstøj** (mange filer over tid) og kompleksitet ved parallelle udviklingsgrene.  

---

### State-based migrations

**Steps udført i projektet:**  
1. Genererede et SQL-script baseret på forskellen mellem nuværende database og model:  
   ```bash
   dotnet ef migrations script -o update.sql
   ```
2. Kørte scriptet mod SQLite databasen.  

Dette script var **idempotent** og kunne køres både i udvikling og produktion for at bringe databasen i sync.

**Begrundelse (faglig vurdering):**  
- State-based tilgangen fokuserer på **sluttilstanden**, ikke historikken.  
- Velegnet til **Continuous Deployment**, hvor ét script kan eksekveres i produktion uden at migrere trinvis.  
- Reducerer kompleksitet ved små projekter eller prototyper.  
- Mangler dog mulighed for fin-grained rollback og **audit trail** af tidligere ændringer.  

---

## Sammenligning – Fordele og ulemper

| Egenskab                | Change-based                                | State-based                          |
|--------------------------|---------------------------------------------|---------------------------------------|
| Historik                | Ja – detaljerede migrationer                | Nej – kun sluttilstand                |
| Rollback                | Muligt, migrations kan køres baglæns        | Vanskeligt, kræver manuelle scripts   |
| Versionskontrol         | Migrationer kan versionstyres i Git         | Kun scriptversioner                   |
| CI/CD                   | Mere kompleks at integrere                  | Nem distribution af ét script         |
| Idempotency             | Afhænger af migreringskode                  | Ofte idempotente scripts              |
| Egnet til               | Store projekter, teams, kompleks schema     | Små projekter, hurtige prototyper     |

---

## Projektstatus og konklusion

Dette projekt viser to migrationsstrategier i EF Core og deres praktiske implikationer:  

- **Change-based**:  
  Giver detaljeret kontrol, fuld versionshistorik og er bedst egnet til store projekter med mange udviklere.  
  Understøtter rollback og granularitet i ændringer, men kan medføre kompleksitet og filophobning.  

- **State-based**:  
  Giver hurtig deployment og enklere pipeline-integration. Egner sig bedst til små projekter, hvor historik ikke er kritisk.  
  Gør det nemt at generere ét script til produktion, men uden rollback og audit trail.  

**Konklusion:**  
Ved at kombinere begge tilgange i dette projekt har jeg opnået en dybere forståelse af **database migrations som disciplin**, samt hvordan forskellige valg kan påvirke **driftsstabilitet, udviklingsworkflow og deploymentstrategier**.

---

