# Audyt — hackathon-multi-ai-blueprint

Audyt całości repo `TomaszGonczar/hackathon-multi-ai-blueprint`, stan `ed776bd` (HEAD,
po 12 commitach od 2026-09-14). Wszystkie liczby poniżej policzone na sklonowanym
repo, każdy cytat ma `plik:linia`.

**Stan: nieaktualny operacyjnie.** To jest rejestr tego, co było w repo
`hackathon-multi-ai-blueprint` przed refaktorem. Zostawiony jako dowód i jako kontekst
do decyzji — **nie jako instrukcja.** Aktualny materiał: [`README.md`](README.md).

**Decyzja podjęta 2026-09-29: obserwator usunięty.** Pytanie, które §4 i §7 tego
pliku zostawiały otwarte, jest rozstrzygnięte — patrz [`04-SYSTEM-PRODUKCJA.md`](04-SYSTEM-PRODUKCJA.md),
sekcja „Merge". Argumenty z §4 pozostają aktualne jako uzasadnienie usunięcia, nie
jako pytanie do dyskusji.

**Co z tego audytu zostało:** §2 (siedem rzeczy wartych zachowania), §3.1 (żywa
sprzeczność, do naprawienia w starym repo), §5 (schemat).

**Co jest dziś operacyjne:** pięć plików `01`–`05`.

---

## 1. Skala

| Plik | Linie | Bajty | Rola operacyjna w sobotę |
|---|---:|---:|---|
| `05_IMPLEMENTATION_CHECKLIST.md` | 675 | 66 KB | checklista, której nie da się wykonać |
| `07_FAILURE_AND_REHEARSAL_PLAN.md` | 512 | 67 KB | audyt samej dokumentacji |
| `03_ARCHITECTURE_BLUEPRINT.md` | 431 | 38 KB | architektura |
| `02_REUSE_LEDGER.md` | 415 | 60 KB | **zerowa** (prowenancja cudzej pracy) |
| `04_DEVELOPMENT_PLAN.md` | 334 | 40 KB | plan |
| `00_DELIVERABLE_CONTRACT.md` | 217 | 14 KB | **zerowa** (jak pisać dokumenty) |
| `08_PORTFOLIO_BRIEF.md` | 206 | 15 KB | **zerowa** (portfolio autora) |
| `09_REVIEW_RECORD.md` | 144 | 17 KB | **zerowa** (dokumenty oceniające siebie) |
| `01_DISCOVERY_CLOSURE.md` | 122 | 10 KB | rejestr pytań |
| `README.md` | 78 | 6 KB | indeks |
| `HISTORY.md` | 28 | 3 KB | log |
| **Razem** | **3 391** | **348 KB** | |
| `06_ARCHITECTURE.mmd` | 161 | — | 30 krawędzi, ELK, nieczytelny |
| `render/06_ARCHITECTURE.png` | — | — | 2384×2855 px |

**Trzy pliki bez wartości operacyjnej to 776 linii i 91 KB — 28% materiału, 0% wykonalności.**

Weryfikacja: `wc -l -c *.md` na sklonowanym repo.

---

## 2. Co jest w tym naprawdę dobre

Nie przesadzam — to jest solidna robota. Konkretnie:

1. **Punkt wyjścia jest poprawny.** Nieznany temat → nie da się przygotować wiedzy,
   da się przygotować proces. `03:50`: *„The system must be topic-agnostic. Its value is
   structure, not answers."* I natychmiastowa reguła *„any component that assumes a
   domain has already failed the brief"* — to jest rzadkie i dobre.

2. **Jeden artefakt przekracza granicę.** Research nie podaje prozy, tylko zamrożony
   pakiet (`03:131`). To zabija najczęstszy tryb awarii — pięć różnych modeli
   problemu u pięciu osób (`03:42`).

3. **Zamrożenie + numerowane poprawki.** `03:152`. Cicha zmiana promptu to *defect*,
   nie update. Poprawne i rzadkie.

4. **Jeden autor na jedną powierzchnię.** `03:180`, `04:166` (P4.8). Najtańsza
   reguła w projekcie i najskuteczniejsza.

5. **Obserwator jest z definicji degradowalny.** `03:261`: *„Under time pressure it is
   switched off and the team loses monitoring, not capability."* Większość projektów
   monitoringu ginie właśnie dlatego, że jest obciążeniowo krytyczny. Autor to
   zapisał jako inwariant, nie jako opcję.

6. **Kolejność cięcia jawna.** `03:315-324` — C0 (nigdy nie ciąć) / C1 (ciąć pod
   presją) / C2 (ciąć najpierw). Ludzie improwizują cięcie pod presją i tną złe
   rzeczy. Tutaj kolejność jest zapisana **zanim** będzie potrzebna.

7. **Trzy zasady, które są tam, bo recenzent je znalazł, a nie dlatego, że autor je
   wymyślił:**
   - *„Instruction is not enforcement"* (`00:43`) — rola opisana jako read-only jest
     read-only tylko jeśli coś czyni mutację niemożliwą
   - *„Agreement is not truth"* (`00:39`) — zgodność źródeł jest własnością źródeł
   - *„Untrusted input is data, never instruction"* (`00:44`) — dodane po przeglądzie
     zagrożeń, patrz `09:90` (finding High #1)

   To jest rzadki i uczciwy wzorzec: luka znaleziona przez outsidera, nazwana,
   naprawiona, zapisana w rejestrze. Nie skasowana.

8. **Uczciwe przyznanie się do niewidzialnego systemu.** `07:139` (PM-4):
   *„The deepest exposure in the design: `OB`'s baseline **is the thing that may be
   wrong**. Deviation-vs-package cannot detect a package that deviates from reality."*
   To jest dokładnie ta awaria, której żaden monitoring tego typu nie wykryje. Autor
   to zapisuje zamiast ukryć.

---

## 3. Co jest zepsute — z dowodami

### 3.1 Żywa sprzeczność między artefaktami, oznaczona jako „naprawiona"

Najmocniejszy finding audytu. Sprawdzone grepem po czterech miejscach:

| Miejsce | Co mówi |
|---|---|
| `01_DISCOVERY_CLOSURE.md:29` | *„Therefore **the short-event branch is closed** and the full cadence applies."* |
| `04_DEVELOPMENT_PLAN.md:322` | *„**The short-event branch is closed**, the cut order becomes pressure-driven…"* |
| `03_ARCHITECTURE_BLUEPRINT.md:326` | *„the short-event cut rules **remain an active fallback branch** rather than permanently closed"* |
| `04_DEVELOPMENT_PLAN.md:239` | *„the short-event cut rules **remain an active fallback branch** rather than permanently closed"* |
| `09_REVIEW_RECORD.md:130` (F-05, MAJOR) | *„**Fixed.** Preserved short-event cut rules as an active fallback branch rather than declaring the branch permanently closed."* |

Rejestr przeglądu deklaruje F-05 jako **Fixed**. Zmieniono **2 z 4** miejsc.
`01` i `04 §14` wciąż mówią, że zdarzenie nie może być krótsze niż 24h — a to
jest informacja z drugiej ręki, oznaczona w samym rejestrze jako `[UNVERIFIED]`
(`01:29`).

**Dlaczego to ważne w sobotę:** jeśli organizator powie „mamy 18 godzin", dwa
pliki mówią wam, że macie plan, a dwa mówią, że plan wymaga przeliczenia. Zespół
nie ma jak sprawdzić, który to jest — bo oba pliki wyglądają równie pewnie.

**Dlaczego to ważne meta:** to dokładnie ta klasa rozjazdu, którą pakiet deklaruje
jako rozwiązaną. `09:74`: *„It does not demonstrate that drift was prevented — eight
violations occurred."* Census (`09:52-75`) ma 10 checków i **nie ma w nim żadnego,
który porównuje treść zdań między artefaktami** — sprawdza identyfikatory, nie
prozę. Więc ten konkretny typ błędu przechodzi przez CI.

### 3.2 Trzy punkty checklisty łamią format tej checklisty

`05:89-91`:

```text
- [ ] **T7-01-1:** Research laptop: AI system pre-installed and tested
- [ ] **T7-01-2:** Developer laptops: Each member clones repo + installs fleet locally
- [ ] **T7-01-3:** Network: All laptops on same Wi-Fi / LAN
```

Format wymagany przez `05:56-63` to pięć pól: `owner`, `trigger`, `ref`, `verify`,
`fail`. Te trzy mają **zero** z nich — nie wiadomo, kto to robi, czym się sprawdzi
i co się dzieje jak nie działa.

Pochodzenie: dodane ostatnim commitem (`ed776bd` / wcześniej `a2d68d3`–`bea9835`,
"Reframe setup from local multi-laptop"). **Po** wszystkich trzech przeglądach.

Reakcja procesu na własne złamanie reguły — `.github/workflows/ci.yml:53-54`:

```python
# Note: T7-01-1, T7-01-2, T7-01-3 are formatted without bullet dot
extra = re.findall(r"^- \[ \] \*\*(T7-01-\d):\*\*", c5, re.M)
```

CI zostało rozszerzone **wyjątkiem dla trzech konkretnych linii**, zamiast naprawić
te linie albo odrzucić je. Licznik nadal raportuje 77 i badge nadal pokazuje
"77 Checks" (`README.md`).

To jest najmniejszy finding w pakiecie i najbardziej wymowny: **proces chroni
własny wynik, nie swoją regułę.**

### 3.3 Nic w tym nie zostało wykonane — i autor pisze to sam, uczciwie

Policzone:

- `07:58` — validation ledger: **13 wierszy, 4 `DESIGNED`, 9 `DESIGNED+CHECKED`, 0 `ENFORCED`**
- `07:119` — control table: **11 reguł, 6 declared+evidenced, 5 declared, 0 enforced**
- `07:90-91` — *„**The enforcement column is empty by design.**"*
- `05:675` — *„Nothing in this checklist has been executed. It is designed, unrehearsed."*
- `00:71` — *„**Nothing in this package is `ENFORCED`.**"*
- `07:144` — *„Review is not execution… A defect-free document set is a claim about the documents."*

Potwierdzone przeliczeniem: `| (V\d+) |` → 13, `| (PM-\d+) |` → 12, pozycje
checklisty → 77 (74 w formacie + 3 wyjątki). Liczby w dokumentach się zgadzają.

**To jest uczciwe i powinno zostać tak w piątek wieczorem powiedziane na głos.**
Natomiast `03` + `04` + `05` + `07` + `09` to 2 042 linie pracy wykonane **wyłącznie
o dokumentach**. Żadna z nich nie zostanie w sobotę przetestowana, bo nie ma na to
czasu. Autor sam pisze, że to nie jest dowód (`09:144`) — i ma rację, tylko że
nikt nie powiedział tego głośno w README.

### 3.4 Okno przygotowaniowe vs. rzeczywistość

- Plan zakłada **T-14 → T-1**, sześć faz przed startem: `04:52-61` (P0 discovery,
  P1 reuse ledger, P2 environment inventory, P3 research machine, P4 development
  fleet, P5 observer, P6 rehearsal).
- `04:63`: *„**P0–P2 are non-negotiable.**"* — w tym tygodniu, z terminem 4 dni.
- Dziś wtorek 2026-09-29; sobota 2026-10-03. **4 dni.**
- `04:52` P0: *„T-14 to T-7"* — ta faza **już się zaczęła** i zaraz się skończy.

To nie jest wada dokumentacji. To jest dopasowanie do realiów, i jest jednoznaczne:
**fazy P0–P6 muszą zostać świadomie odcięte, albo zespół spędzi sobotę na
budowaniu procesu zamiast produktu.**

### 3.5 Plan jest nieegzekwowalny bez 18 liczb

`05:149` (T7-09) wymaga **osemnastu** stałych, każdej ze źródłem, zero TBD:
`<event-window>`, `<approval-budget>`, `<startup-budget>`, `<cycle-overhead-budget>`,
`<triage-budget>`, `<c0-floor-target>`, `<freeze-threshold>`, `<submission-buffer>`,
`<push-interval>`, `<report-cadence>`, `<retry-interval>`, `<commit-interval>`,
`<escalation-window>`, `<clock-skew-tolerance>`, `<triage-window>`, `<converge-window>`,
`<fix-window>`, `<demo-duration>`, `<manual-status-window>`, `<reassignment-window>`,
`<min-battery>`, `<min-free-disk>`.

Wszystkie są `TBD` i mają zostać wypełnione w fazie T-7 (`04:241-251`). Bez nich
`DC-04` (push cadence), `FZ-01` (freeze), `DC-12` (triage), `DC-10` (human override)
nie mają kryterium przejścia. W sobotę potrzebnych jest **6 z nich** — reszta to
precyzja, której nikt nie zauważy.

Szczególnie: **okno bezczynności nie istnieje jako liczba.** `07:141` (PM-6):
*„'Stall' needs a window, and the window value does not exist yet — an unstipulated
window means either noise or silence."* Własne podsumowanie projektu wyznacza
problem, którego rozwiązania nie dostarcza.

### 3.6 Trzy nierozwiązane pytania, z których każde może zabić komponent

`01:93-97`, autor sam nazywa je „load-bearing":

| # | Pytanie | Co zabija |
|---|---|---|
| `Q9` | czy organizacja wyda token ograniczony do odczytu | cały claim read-only obserwatora → D7 |
| `Q10` | kto jest merge-person | reguła D6 nie ma adresata → first integration point to ad-hoc decision pod presją |
| `Q6` | który laptop może żyć 24h+ | obserwator nie działa w nocy → zaprojektowana funkcja staje się intermittent |

Wszystkie trzy `OPEN` (`01:31-36`). Dwa z nich dotyczą wprost obserwatora.

---

## 4. Obserwator — spór rozstrzygnięty: USUNIĘTY (2026-09-29)

Poniżej argumenty obu stron zebrane przed decyzją. Zostały jako **uzasadnienie
usunięcia**, nie jako pytanie. Zamiennik i uzasadnienie:
[`04-SYSTEM-PRODUKCJA.md`](04-SYSTEM-PRODUKCJA.md), sekcja „Merge — człowiek, review
w świeżym kontekście".

To był **jedyny** komponent, który jest oryginalny. Nie jedyny, który jest potrzebny.

### Koszt

- Laptop, który nie zasypia 24h+ — `Q6`, **otwarte** (`01:36`)
- Token read-only w organizacji, którą zespół może nie kontrolować — `Q9`, **otwarte**
  (`01:35`); `07:142` (PM-7): *„If unscoped, there is no mechanical barrier between
  `OB` and `REPO` writes — only the credential's absence from any write path and
  the honesty of the claim."*
- Okno bezczynności jako liczba — nie istnieje (`07:141`)
- Procedura start/stop na długowiecznym procesie — dopisana jako P5.7 dopiero po
  przeglądzie (`09:29`, finding MAJOR #4: *„No task installed, started, or stopped the
  long-lived observer process, although later items presupposed it running"*)

### Przewaga (nad uczciwością autorów)

- **Ocenia sam siebie.** Ten sam laptop napisał Brief i mierzy się według niego
  (`07:137`, PM-2). Mitygacja to schemat raportu bez pola oceny — ale to **kształt
  obietnicy, nie kontrola** (`07:67`, V6: *„The schema artifact does not exist yet,
  so even the trivial inspection has nothing to run against"*). Dodatkowo selekcja
  (czego obserwator w ogóle szuka) jest poza zasięgiem schematu.
- **Nie wykryje najważniejszej awarii.** `07:139` (PM-4) — patrz §2 pkt 8.
- **Żadna drilla nie testuje nocy.** `07:148` (PM-12) i `08:149`: *„The night window
  is `[UNPROVEN]`: drills 6.1–6.8 run in a single sitting, so the noise bound has
  never been tested at 03:00."*

### Reakcja projektu

Autor zna obie strony. `09:102` (finding Low #13) odmawia obniżenia obserwatora
do C2: *„it is the component the engagement exists to design… Cutting it to `C2`
would remove the design's differentiator."* I jednocześnie przyjmuje
zarzut i zapisuje go: *„the benefit remains `[UNPROVEN]` until a drill shows a
consumer for its alerts."*

**To jest uczciwe, ale jest to też definicja przedmiotu dyskusji.** Nie decyzja —
do decyzji. Rekomendacja: wersja manualna (patrz `README.md` §7 pytanie 1).

---

## 5. Schemat

`render/06_ARCHITECTURE.png` — 2384×2855 px, przeglądane: 1309×1568.

Obejrzałem. Fakty opisane w repo są prawdziwe i wszystkie odwrotnie niż pomocne:

- **Lane'y ułożone 2, 5, 3, 4, 1** przez auto-layout ELK — przyznane w `.mmd:37-40`
  i w legendzie. Kolejność jest losowa i udaje, że jest strukturalna.
- **Legenda jest w prawym dolnym rogu** — czytelnik musi wrócić na dół po pięć
  etykiet, żeby zrozumieć kolor, który właśnie widzi.
- **Lewa połowa kanwy (ok. 30%) to pusty bounding box** subgraphu `RUNTIME`,
  z jedną linią idącą dookoła.
- **Etykiety środkiem diagramu, oderwane od krawędzi** — *„approval record"*,
  *„degraded: adopt frozen package locally if S1 lost (any lane)"* leżą na
  pustej przestrzeni z dala od obu końców swojej krawędzi.
- 30 krawędzi, 4 klasy wizualne, ELK `direction: DOWN` zmieniony z `RIGHT` tylko
  dlatego, że w `RIGHT` tekst 14 px skalował się do ~5.5 px (`.mmd:41-44`).
- Konfiguracja `elk.spacing.*` jest **w kodzie, ale nie robi nic** —
  `.mmd:49-51`: *„verified inert in mermaid 11.17.2: three spacing configurations
  produced byte-identical viewBox geometry."*

Najważniejsze: przegląd z 2026-09-15 **widział ten problem i odmówił go naprawienia**
(`09:99`, finding Med #10): *„Declined: shipping a second, simplified reviewer render
— two diagrams would create a second source of truth for the same system, which is the
failure this package is written against."*

Argument jest poprawny **w swoim własnym świecie** (pakiet, który uzasadnia
jednoznaczność artefaktów, nie może mieć dwóch). Ale warunek, który go czyni
trafnym — *„The full diagram is legible at 2400 px"* — nie jest spełniony w sposób,
w jaki czyta się README, czyli w skali, w której zespół musi to zrobić.

**Konflikt z własnym kryterium odbioru.** `03:75`: *„Whatever is prepared must
survive a participant who has never read the blueprint."*
`04:296` (kryterium akceptacji): *„A new reader answers blueprint §12 unaided."*
Kryterium wymaga zimnego czytania **431-liniowego blueprintu** i wykresu
**2855 px w pionie**. To nie jest kryterium, które da się spełnić o 3:00 w nocy.

---

## 6. Role

`05:38-46` definiuje 7 typów slotów. `09:98` (finding Med #9) liczy to inaczej:
*„Nine named authority slots for five people"* i dodaje do kolejki cięcia wiersz
*„Role collapse"* (`03:322`).

**Autor przyznaje wprost, że role się nie mieszczą, i dodaje wiersz „zwiń role"
do kolejki cięcia.** To jest uczciwe i to jest odpowiedź: na 5 osób potrzebne są
**2 nazwiska** (Mózg, merge-person), nie 9 slotów. Reszta ról to funkcja przy
okazji.

---

## 7. Podsumowanie: co zostaje po audycie

| | |
|---|---|
| **Zachować w całości** | `03:31-52` (punkt wyjścia), `03:131-152` (Brief + zamrożenie), `03:176-184` (jeden autor na powierzchnię), `03:284-297` (merge = człowiek, „instruction is not enforcement"), `03:259-261` (degradowalność), `03:315-324` (kolejność cięcia), `00:39/43/44` (trzy zasady) |
| **Zredukować do jednej strony** | `03` 431 → ~1,5 strony; `04` 334 → plan godzinowy z `README.md` §6 |
| **Wyrzucić przed sobotą** | `00`, `02`, `09` (776 linii, 28% korpusu) |
| **Zastąpić** | `06_ARCHITECTURE.mmd` + PNG → `diagram-prosty.mmd` (12 pudełek, 10 strzałek) |
| **Naprawić przed startem** | sprzeczność `01:29` / `04:322` vs `03:326` / `04:239` (§3.1) |
| **Zdecydować wieczorem** | obserwator: proces czy człowiek; 2 nazwiska; 6 liczb |

**Jedno zdanie:** 85% wartości jest w pięciu regułach z `README.md` §2. Reszta
dokumentacji jest obwarowaniem, prawdziwym, ale adresowanym do odbiorcy, który
nie przyjdzie — bo w sobotę o 3:00 nad ranem nikt nie przeczyta 348 KB.
