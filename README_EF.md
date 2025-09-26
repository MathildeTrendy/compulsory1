# EF (Change-based) Migrations — Student Management

## Hvorfor migrations?
Vi ændrer databasen lidt ad gangen og gemmer hver ændring. 
Så kan vi se historikken, fortryde hvis det går galt, og 
få en SQL-fil at køre. Her har vi gjort det fra V1 til V7.

## Sådan køres det
```bash
# Opdatér DB til seneste version
dotnet ef database update \
  --project compulsory1/compulsory1.csproj \
  --startup-project compulsory1/compulsory1.csproj

# Generér samlet script (fra tom DB til V7)
dotnet ef migrations script 0 V7_ChangeCreditsToDecimal \
  --project compulsory1/compulsory1.csproj \
  --startup-project compulsory1/compulsory1.csproj \
  -o artifacts/ef/upgrade.sql
