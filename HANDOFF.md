# KAPSULA HANDOFF — nowa sesja OMP

> **STATUS: ZAMKNIĘTE (2026-10-02).** Zadania T1–T6 wykonane; wynik jest na
> `main` (PR #1–#5). Branche robocze `refactor/dwa-systemy` i `refactor/seed`
> **usunięte po merge'u**. Ten plik jest odtąd **zapisem zlecenia, nie instrukcją** —
> komendy w §6 są historyczne. Aktualny stan: `README.md` i `seed/`.

> Ten plik jest pierwszą rzeczą, którą przeczytasz. Zawiera wszystko, czego potrzebujesz,
> żeby zacząć. Nie pytaj o nic, czego tu nie ma — pytanie o rzecz, której nie opisałem,
> jest informacją samą w sobie i zapisz ją w §6 raportu.

**Czas:** piątek wieczór, 30.09→02.10. **Hackathon: jutro, sobota 03.10.**
To nie jest zadanie na tydzień. To jest zadanie na **dziś wieczorem**, z wynikiem
na jutro rano.

---

## 1. Co robisz

**System 1** tego projektu, zastosowany do samego projektu.

Dostajesz repo z gotowym blueprintem hackathonu. Twoje zadanie:

> **Znajdź dziury, uprość co się da uprościć, i zostaw rzecz najbliższą planowi
> developmentowemu — tak, żeby twój kumpel jutro rano mógł jednym poleceniem
> z Claude Code Pro stworzyć repozytoria i zacząć pracować.**

Nie projektujesz architektury. Ona już jest i jest rozstrzygnięta. **Twoje zadanie
to dziury i drożność**, nie kształt.

### Czego NIE robisz (to jest ważniejsze niż lista zadań)

- **Nie przebudowujesz architektury.** Dwa systemy, kapsuła, maszynowy merge —
  to jest ustalone. Jeśli uważasz, że to złe, zapisz to w §6 raportu z argumentem
  i jedź dalej. Nie edytuj tych plików bez powodu.
- **Nie piszesz nowych reguł procesowych.** Projekt przeszedł trzy rundy
  upraszczania: 3 391 → 1 246 → 1 188 linii. Każda kolejna reguła jest podejrzana
  domyślnie. Pytanie brzmi: *czy ta linia zapobiega konkretnej pomyłce?*
- **Nie dodajesz plików, chyba że wynikają z zadania.** Wszystko, co dodasz,
  musi mieć w raporcie uzasadnienie jednym zdaniem.
- **Nie zakładaj, że coś jest zepsute, bo nie rozumiesz.** Jeśli nie potrafiłeś
  czegoś ogarnąć — napisz to jako pytanie, nie jako werdykt.

---

## 2. Stan rzeczy — nie odkrywaj tego od nowa

Wszystko poniżej **jest zweryfikowane** i nie potrzebuje ponownego sprawdzania.

**Repo:** `https://github.com/TomaszGonczar/hackathon-multi-ai-blueprint`
**Branch roboczy:** `refactor/dwa-systemy` — *usunięty po merge'u; cała praca jest na `main`.*
**`main` był nietknięty w trakcie pracy** — zmienił się dopiero przez zatwierdzony merge.

### Co jest zrobione

| Rzecz | Stan | Dowód |
|---|---|---|
| Audit oryginalnego pakietu (10 plików, 3 391 linii) | zrobiony | `archiwum/AUDYT.md` |
| Refaktor na dwa systemy | zrobiony | commit `9ac2fb4` |
| Research 60 min + maszynowy merge | zrobiony | commit `e36df9a` |
| `AGENTS.md` jako kontekst i stan systemu | zrobiony | commit `b57cc84` |
| Provider `atria` w OMP | działa, przetestowany | `~/.omp/agent/models.yml` |

### Znane dziury w oryginale (udokumentowane, **nie naprawiaj ich**)

1. **Żywa sprzeczność.** `01_DISCOVERY_CLOSURE.md` i `04 §14` mówią „short-event
   branch is closed", `03 §8.2` i `04 §10` mówią „aktywna gałąź rezerwy".
   Rejestr przeglądu (`09_REVIEW_RECORD` F-05) deklaruje to jako naprawione.
   Naprawione w 2 z 4 miejsc. → `archiwum/AUDYT.md` §3.1
2. **Trzy punkty checklisty łamią format tej checklisty**, a CI zostało rozszerzone
   wyjątkiem dla nich zamiast naprawy. → `archiwum/AUDYT.md` §3.2
3. **Nic w oryginale nie zostało wykonane.** 0 `ENFORCED`, 0 prób generalnych.

Te trzy są **udokumentowane i świadomie zostawione**, bo dotyczą plików, których
nie ruszamy. Nie są twoim zadaniem.

### Decyzje już podjęte — nie wracaj do nich

| # | Decyzja | Stan |
|---|---|---|
| 1 | Obserwator usunięty, zastąpiony review w świeżym kontekście | zamknięte |
| 2 | Research 60 min, 5 sesji | zamknięte |
| 3 | Merge robi maszyna; człowiek wchodzi 2× (sync, freeze) | zamknięte |
| 4 | Jeden przewód: `KAPSULA.md` | zamknięte |
| 5 | Brak pamięci — system żyje 2 dni | zamknięte |
| 6 | OMP jako runtime, bez meta-harnessa | zamknięte |
| 7 | Reguły w `AGENTS.md §4`, reszta to uzasadnienie | zamknięte |

---

## 3. Twój zakład — to zmienia priorytety

Twój kumpel ma **2× Claude Pro (x20) i 1× ChatGPT (x10)**. Projekt stoi na zakładzie,
że **mocne modele i dużo tokenów są do zdobycia i mają być wydane**. Większość tego,
co wygląda na rozsądne oszczędzanie, jest błędem.

**Wąskie nie są tokeny. Wąskie są:**
- uwaga (kto czyta, kto decyduje)
- kontekst jednej sesji
- kolizje
- synteza

Twój model ma 256K kontekstu. Cały korpus tego repo to ~7 200 słów, czyli
**~20K tokenów** — masz zapas na trzydzieści razy więcej, niż tu jest. Możesz
przeczytać wszystko naraz i nie musisz nic pamiętać między sesjami.

---

## 4. Zadania — wykonaj po kolei

### T1 · Czytaj z krytykiem, nie z notatkami

Przeczytaj `README.md`, `AGENTS.md`, `KAPSULA.md`, `1-RESEARCH.md`, `2-BUILD.md`,
`3-CHEATSHEET.md`. Zanotuj każde miejsce, w którym **pliki mówią różne rzeczy albo
przesłaniają odpowiedzialność.**

Kryterium przejścia: lista zdań typu *„plik X mówi A, plik Y mówi B"*, z numerami
linii. Puste znaczy, że korpus jest spójny — i to też jest wynik, zapisz go.

### T2 · Dziesięć rzeczy, które nie zadziałają jutro rano

To jest **główny wynik twojej pracy.** Zespół o 8 rano ma 15 minut i jedno okno
terminala. Znajdź dziesięć rzeczy, które się w tym oknie zepsują.

Kandydaci do sprawdzenia (ale szukaj też własnych):
- czy kapsuła da się wypełnić w 10 minut przez 5 osób, które **nie znają** tematu
- czy `check.sh` da się napisać, nie znając rozwiązania (a rozwiązania jeszcze nie ma)
- czy katalogi worktree nie kolidują z trybem pracy, w którym ludzie nie znają gita dobrze
- czy cokolwiek wymaga tokenu, konta albo sieci, których **nie wiadomo** że mają
- czy kolejność „czeka na" da się ustalić przed poznaniem rozwiązania
- czy cokolwiek zakłada, że agent zrobi coś sam, a nikt tego nie sprawdza

Kryterium przejścia: dziesięć punktów, każdy z **konkretnym zdaniem co zrobić**,
nie z diagnozą.

### T3 · Uprość to, co nie broni pomysłu

Mandat: **podejrzane domyślnie**. Dla każdego elementu odpowiedz:
*czy to zapobiega konkretnej pomyłce, którą widziałem, czy tylko wygląda, jakby
zapobiegała?*

Usuń albo wyprość to, co odpowiada „tylko wygląda". **Nie usuwaj:**
- maszynowej kolejności mergów (bez niej pętla stoi w nocy)
- reguły o interfejsach (bez niej maszyna rozwiąże konflikt po cichu)
- `check.sh` (bez niego nie ma pętli)
- `AGENTS.md` (agent nie wie, w jakiej jest sytuacji)

Kryterium przejścia: lista usuniętych/uproszczonych rzeczy **z jednym zdaniem
racjonowania każdej**. Zostawiona lista też jest wynikiem — powiedz, co odwiedziłeś
i zostawiłeś.

### T4 · Plan developmentowy — rzecz najbliższa planowi

Napisz `DEVPLAN.md`: co konkretnie zrobić **od jutra 8:00 do wysłania**, w kolejności,
z rolami. To ma być lista, którą da się odhaczyć, nie dokument do przeczytania.

Wymagania:
- zaczyna się od piątku wieczorem, bo to jest ten sam dzień
- każdy krok ma właściciela i warunek przejścia, który da się zobaczyć
- **jest plan awaryjny** na wariant „nie zdążyliśmy zasadzić seedów”
- mówi wprost, co się dzieje, jeśli temat okaże się inny niż zakładano
- **nie powtarza `3-CHEATSHEET.md`** — to zegar dla człowieka, `DEVPLAN.md` to kolejność
  pracy z przypisaniami

Kryterium przejścia: czytelnik, który nie był przy żadnej rozmowie, wykonuje to
w sobotę rano bez pytania do nikogo.

### T5 · Seed — to jest najważniejszy wynik

Przygotuj `seed/`, z którego **Claude Code Pro x20 w trybie auto stworzy
repozytoria jutro rano jednym poleceniem.**

To jest twarde ograniczenie, które decyduje o formie:

> Bot ma działać **bez pytania do człowieka.** Jeśli seed wymaga pytania,
> bot zatrzyma się w najgorszym możliwym momencie — pierwszej minucie hackathonu.
> **Każdy element seeda musi mieć wartość domyślną i działać bez interwencji.**

Seed musi zawierać:

```text
seed/
├── SEED.md              ← co to jest, jak uruchomić, jedno polecenie
├── bootstrap.sh         ← idempotentny: można go odpalić 2× bez szkód
├── repo-layout.md       ← struktura katalogów, nazwy branchy, worktree
├── templates/
│   ├── AGENTS.md        ← z STAN: BUILD, gotowy do wklejenia
│   ├── KAPSULA.md       ← szablon z nagłówkiem i 6 blokami
│   ├── check.sh.example ← działający wzorzec, exit 0/1
│   └── START-HERE.md    ← co czytać, w jakiej kolejności, pierwsze 30 min
└── VERIFY.md            ← jak sprawdzić, że seed zadziałał, zanim zacznie się hackathon
```

Wymagania do `bootstrap.sh`:
- **idempotentny** — odpalenie drugi raz nie niszczy istniejących katalogów
- tworzy repo i 5 worktree, każdy z `check.sh`
- kopiuje `AGENTS.md` i `KAPSULA.md` do katalogu głównego **repo rozwiązania**
  (tam agent je wczytuje — nie do repozytorium blueprintu)
- **nie wymaga żadnego sekretu** ani tokenu, którego nie wymagają reszta
- wypisuje na końcu checklistę weryfikacji
- kończy się `exit 0` albo `exit 1` — nigdy „pół na pół”

**Kryterium przejścia `VERIFY.md`:** ktoś na czystej maszynie, bez Twojej pomocy,
uruchamia `bash seed/bootstrap.sh`, robi test, i w **10 minut** ma pięć działających
katalogów z zielonym `check.sh`. Zapisz dokładnie tę komendę i dokładnie ten czas.

### T6 · Raport — `RAPORT.md`

Maksymalnie 150 linii. Pięć sekcji, po jednym akapicie:
1. **Dziesięć dziur** — z T2, każda z działaniem
2. **Co uprościłeś** — z T3, z racjonowaniem
3. **Co zostawiłeś mimo wątpliwości** — i dlaczego
4. **Seed: jak sprawdzić, że działa** — z T5
5. **Pytania, na które nie mam odpowiedzi** — jedno do trzech

**Raport ma być krótki.** Jeśli nie mieści się w 150 liniach, to zadanie nie
jest zrobione — znaczy, że piszesz o procesie zamiast o wyniku.

---

## 5 · Czego nie wolno

- **Nie commituj niczego na `main`.** Cała praca na `refactor/seed` — nowy branch
  od `refactor/dwa-systemy`. *(Historyczne: po zatwierdzonym merge'u wszystko jest
  na `main`, branche usunięte.)*
- **Nie usuwaj `archiwum/`, `00_`–`09_`, `render/`, `LICENSE`, `HISTORY.md`.**
  To cudza praca i dowód. `AGENTS.md` mówi, że ich się nie czyta, i to jest w porządku.
- **Nie wklejaj żadnych sekretów.** W tym repo nie ma kluczy. Klucz do Atria żyje
  w `~/.omp/agent/models.yml` i w keychainie macOS — **nigdy go nie kopiuj** i nie
  pokazuj w zadaniu ani w commicie.
- **Nie zmieniaj `AGENTS.md §4`** (reguły operacyjne) bez powodu opisanego w T3.
- **Nie pisz po polsku w `seed/bootstrap.sh`** — kod, komentarze techniczne po
  angielsku, dokumenty po polsku. Bot czyta inaczej niż człowiek.

---

## 6 · Jak zacząć, dosłownie

```bash
git clone https://github.com/TomaszGonczar/hackathon-multi-ai-blueprint
cd hackathon-multi-ai-blueprint
```

Potem przeczytaj ten plik od nowa i zacznij od **T1**.

Pytania, na które nie mam odpowiedzi, są w `RAPORT.md` §5. Nie blokuj się na
żadnym z nich — **T2, T3 i T5 da się zrobić niezależnie.**

---

## 7 · Co dostanę

Pisuj do `RAPORT.md` w worktree. Nie czekaj na koniec — po każdym zadaniu dopisz
sekcję, żeby przerwanie pracy nie kosztowało wyniku.

Najważniejsze, w kolejności:
1. **seed działający i zweryfikowany** (T5)
2. **lista dziur z działaniami** (T2)
3. **`DEVPLAN.md`** (T4)
4. uproszczenia (T3), raport (T6)

Jeśli zabraknie ci czasu i zrobisz tylko jedno — zrób **T5**. Reszta jest wartościowa,
ale seed jest tym, bez czego jutro rano nic się nie uruchomi.