# RAPORT.md

Hackathon sobota 03.10, wynik o piątek wieczór. Branch `refactor/seed` od
`refactor/dwa-systemy`. Seed zweryfikowany, zielony.

---

## 1. Dziesięć dziur — każda z działaniem

1. **`check.sh` nie może istnieć przed kodem, a reguła każe.** Seed daje bramkę
   fazy: `PHASE=0` kończy 1, `PHASE=1` kończy 0. Zasada staje się wykonalna.
2. **Wzorzec sekretu łamie się przy pustym staging area.** `grep` w `&&` pod
   `set -e`. Zamienione na `if ... then exit 1; fi` — w `2-BUDOWA.md` i seedzie.
3. **`./w3/check.sh` wskazuje na katalog, którego nie ma.** `git worktree add
   ~/w3-modele` zostawia `check.sh` w roocie. Naprawione: `./check.sh` z worktree.
4. **Kapsuła pokazuje łańcuch `&&` na pięć kawałków, a mówi „jedna komenda na
   kawałek".** Rozbite na pięć komend z `cd` do worktree.
5. **Nazwy katalogów są fikcyjne, a nazwać trzeba w piątek, gdy tematu nie ma.**
   Przeniesione na 0:55, seed daje `w1-kawalek`…`w5-kawalek` + `git worktree move`.
6. **`STAN: BUDOWA` w pliku wczytywanym przed ogłoszeniem tematu.** Seed generuje
   `STAN: PRZYGOTOWANIE` + warunek *„przed T0 nie budujesz"*.
7. **`research/` jest niewidoczne z worktree agenta** (żyje na branchu systemu-1).
   Zapisane w `DEVPLAN.md` B4: system-1 commituje na `main` o 0:55, agent czyta
   `git show origin/main:research/...`. Do ustalenia przez zespół — patrz §5.
8. **Piątkowy smoke test wymaga `gh` i `jq`.** Alternatywa `git push --dry-run`
   w `DEVPLAN.md` P2 i `seed/VERIFY.md`. `3-PIESC.md` nie ruszany (zegar, zakaz
   zależności).
9. **`git worktree add -b w3` wybucha, gdy branch już istnieje** (kolega wpiął
   się wcześniej). Bootstrap sprawdza `show-ref` i attachuje, nie `-b`.
10. **Idempotentność psuł `git worktree list` + string match.** macOS rozwiązuje
    `/tmp` → `/private/tmp`, więc wzorzec nigdy nie pasował, drugi run rzucał
    *„already exists"*. Zamienione na `[ -e "$target/.git" ]`.

**9 i 10 znalazłem testując seed na żywo — nie z lektury.**

## 2. Co uprościłem

Cztery nieprawdziwe zdania w `README.md`: *„cztery pliki"* (jest pięć),
*„siedem reguł"* (jest osiem), *„1 188 linii"* (jest 1 197), *„OMP jest runtime"*
(runtime jest heterogeniczny — każdy przynosi własnego coding agenta).

**Nic nie usunąłem.** Powód: to, co wyglądało na nadmiar, było albo
**niezbędne** (kolejność mergów, reguła interfejsów, `check.sh`, całe
`AGENTS.md §4`), albo **błędne** — a błędne zdanie naprawia się mniejszym
kosztem niż usuwa. Pełna lista z racjonowaniem: `T3-UPROSZCZENIA.md`.

## 3. Co zostawiłem mimo wątpliwości

- **`3-PIESC.md:13-16`** — `gh api` + `jq`. Realna dziura, ale to zegar dla
  człowieka, a HANDOFF §5 zakazuje nowych zależności. Dziurę przekazałem do
  `DEVPLAN.md`/`VERIFY.md` zamiast edytować zegar.
- **D07 (`research/`)** — zostawione otwarte, bo to decyzja zespołu o gałęziach,
  nie o seedzie. Zobacz §5.
- **`AGENTS.md §4` nietknięty.** Osiem reguł, każda zapobiega konkretnej
  pomyłce. Usuwasz jedną, tracisz noc.
- **Sprzeczność udokumentowana w oryginale** (`01_DISCOVERY_CLOSURE.md` vs
  `03 §8.2`) — HANDOFF §2 mówi wprost: **nie naprawiaj, nie twoje**.

## 4. Seed: jak sprawdzić, że działa

```bash
bash seed/bootstrap.sh            # jeden raz, tworzy repo + 5 worktree
```

Potem 8 testów z `seed/VERIFY.md`. **Sprawdzone na czystym środowisku** (nowy
`$HOME`), wszystkie zielone:

| # | Test | Wynik |
|---|---|---|
| 1 | bootstrap kończy 0 | exit 0, 0.8 s |
| 2 | pięć katalogów | 5 |
| 3 | `check.sh` wykonywalny | 5× OK |
| 4 | faza 0 kończy 1 | 5× exit 1 |
| 5 | faza 1 kończy 0 | exit 0 |
| 6 | sekret łapany (w obu fazach) | exit 1 + `FAIL: sekret` |
| 7 | idempotentność (2. run) | brak `fatal`/`FAIL`, 5 worktree |
| 8 | kontekst w roocie repo | `AGENTS.md`, `KAPSULA.md`, `STAN: PRZYGOTOWANIE` |

Test 6 wykrył błąd w mojej pierwszej wersji — bramka fazy przerywała przed
sprawdzeniem sekretów. Naprawione, retest zielony.

**Ręczny czas:** poniżej minuty na całą procedurę. Pięć katalogów z zielonym
`check.sh` gotowych.

## 5. Pytania, na które nie mam odpowiedzi

1. **Na jakim branchu żyje `research/`?** `AGENTS.md:141` każe czytać
   `research/*.md` z worktree agenta, ale nikt nie napisał, gdzie system-1 to
   commituje. Moja propozycja: `main` o 0:55 + `git show origin/main:...` —
   ale to **zmienia sposób pracy systemu-1**, więc decyzja zespołu.
2. **Czy dwie osoby mogą mieć ten sam numer kawałka?** Seed zakłada, że nie
   (worktree nadpisany by był). Ale `AGENTS.md §4.1` mówi *„w swoim katalogu"*,
   a kapsuła definiuje pięć kawałków dla pięciu osób — nie ma reguły na
   szósty agent (np. do review). Opcjonalne sesje review z `README.md:160` nie
   mają katalogu.
3. **W jakim języku budecie pisać?** `check.sh` jest neutralny, ale sekcja 3
   *„czy test coś łapie"* musi być wypełniona prawdziwym testem, a to wymaga
   języka. Nie wiem, bo temat nie jest znany — i nie powinien być.

---

**Pliki dodane:** `seed/` (7 plików), `DEVPLAN.md`, `T1-SPRZECZNOSCI.md`,
`T2-DZIESIEC-RZECZY.md`, `T3-UPROSZCZENIA.md`, `RAPORT.md`.
**Pliki zmienione:** `README.md`, `KAPSULA.md`, `2-BUDOWA.md` (21 insertów,
14 deletów — same poprawki faktów i ścieżek).
**`main` nietknięty.** Sekrety nigdzie nie figurują.
