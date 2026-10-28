# Echte accounts instellen (uniek voor iedereen)

Een website op Render kan zelf niets onthouden over andere mensen. Daarom bewaar je de accounts in een gratis online database: **Supabase**. Supabase bewaart ook de wachtwoorden veilig (versleuteld). Jij ziet de wachtwoorden nooit.

Zolang je dit niet doet, werkt "jij" in de timer ook, maar dan staat een account alleen in de browser van dat apparaat. Een naam is dan alleen uniek op dat apparaat.

Je hoeft maar één keer 7 stappen te doen.

## Stappen

1. **Account maken.** Ga naar supabase.com, kies "Start your project" en maak een gratis account (bijvoorbeeld met je GitHub-account).
2. **Project maken.** Klik op "New project". Kies een naam (bijvoorbeeld `twc-timer`), bedenk een databasewachtwoord (bewaar dat ergens) en kies een regio dicht bij jou (bijvoorbeeld Frankfurt). Wacht een paar minuten tot het project klaar is.
3. **De database klaarzetten.** Klik links op **SQL Editor** en dan op "New query". Open het bestand `accounts.sql`, kopieer alles, plak het in het venster en klik op **Run**. Je ziet "Success".
4. **Bevestigingsmail uitzetten (aanbevolen om te beginnen).** Ga naar **Authentication**, dan **Providers** (of **Sign In / Providers**) en klik op **Email**. Zet "Confirm email" uit en klik op **Save**. Laat je dit aan staan, dan moet iedereen eerst een link in een mail aanklikken. De gratis mailservice van Supabase verstuurt maar een paar mails per uur.
5. **De gegevens kopiëren.** Ga naar **Project Settings**, dan **API** (of **API Keys**). Kopieer de **Project URL** en de sleutel die **anon** of **public** heet. Neem NOOIT de sleutel met de naam **service_role** (die is geheim).
6. **In index.html plakken.** Zoek in `index.html` naar `ACCOUNT_CONFIG`. Zet je gegevens tussen de aanhalingstekens:

   ```js
   const ACCOUNT_CONFIG = { url: "https://jouwproject.supabase.co", anonKey: "jouw-lange-anon-sleutel" };
   ```

   De anon-sleutel mag openbaar zijn. De regels in `accounts.sql` zorgen ervoor dat niemand andermans gegevens kan lezen.
7. **Online zetten.** Zet `index.html` opnieuw op GitHub (Edit, plakken, Commit changes). Render zet het daarna vanzelf online.

## Testen

- Open je website, klik linksonder op **jij**, kies "Account aanmaken", en vul naam, e-mailadres en wachtwoord in.
- In Supabase zie je het account onder **Authentication > Users**. De naam staat onder **Table Editor > profiles**.
- Probeer met een tweede browser (of een privévenster) dezelfde naam. Je krijgt dan de melding dat de naam bezet is.

## Goed om te weten

- Een gratis Supabase-project wordt na ongeveer een week zonder gebruik gepauzeerd. In je Supabase-dashboard zet je het met één klik weer aan.
- Je tijden en je dagelijkse scramble staan nog steeds in de browser. Het account bewaart nu alleen wie je bent. Tijden en een ranglijst koppelen aan je account kan later.
- Wachtwoord vergeten is nog niet ingebouwd.
