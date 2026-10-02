# T2 — Dziesięć rzeczy, które nie zadziałają jutro rano

Każda: diagnoza + **konkretne zdanie co zrobić**. D01, D03, D07, D09, D10
sprawdzone na żywo (nie z lektury).

---

**D01. `check.sh` nie może istnieć przed pierwszą linią kodu, a reguła każe.**
`AGENTS.md:85-89` (*„test zanim kod"*) jest niewykonalna dosłownie: rozwiązania
jeszcze nie ma, więc nie ma czego testować, a `3-CHEATSHEET.md:23` każe mieć gotowy
`check.sh` już w piątek.
**Co zrobić:** seed daje `check.sh` z bramką fazy — `PHASE=0` kończy 1, `PHASE=1`
kończy 0. Zasada staje się wykonalna: plik istnieje przed kodem, a *zielony*
oznacza wypełniony, nie przypadkowy. **Zrobione w `seed/templates/check.sh.example`.**

**D02. Sekret o pustym staging area (`set -euo pipefail` + `grep` o kodzie 1).**
`2-BUILD.md:83` używa `git diff --cached | grep ... && { exit 1; }` — przy pustym
diffie `grep` zwraca 1 i `set -e` zachowuje się nieterminowanie w potoku.
Sprawdziłem: wzorzec działa (0 na pustym, 1 z `API_KEY=x`), **ale pod `set -e`
wymaga, by staging nie był pusty, albo by grep był w `if`** — a to różnica, której
nikt nie zgadnie o 3 w nocy.
**Co zrobić:** zamienić na `if git diff --cached | grep ...; then exit 1; fi`.
**Zrobione w `2-BUILD.md:83` i w szablonie seeda.**

**D03. `./w3/check.sh` wskazuje na katalog, którego nie ma.**
`2-BUILD.md:43-47` robi `git worktree add ~/w3-modele -b w3`, więc root worktree
to `~/w3-modele`. Wtedy `./w3/check.sh` (`2-BUILD.md:27`, `KAPSULA.md:93`) to
`~/w3-modele/w3/check.sh` — nie istnieje. `2-BUILD.md:68` (`cd "$(dirname "$0")/.."`)
wskazuje na `~/`. Sprawdziłem na żywo: worktree po `add` nie ma `w3/` w środku.
**Co zrobić:** `check.sh` leży w **roocie worktree**, wywołanie to `./check.sh`.
**Zrobione: `KAPSULA.md:110`, `2-BUILD.md:22,27,66,68`, seed.**

**D04. Kapsuła pokazuje jedną komendę na pięć kawałków, komentarz mówi per kawałek.**
`KAPSULA.md:88` (komentarz) — *„JEDNA KOMENDA NA KAWAŁEK"*; `KAPSULA.md:93`
(przykład) — `./w1/check.sh && ./w2/... && echo $?`. Agent o 1:00 nie znajdzie
swojego kawałka w tym łańcuchu.
**Co zrobić:** pięć osobnych komend z `cd` do worktree. **Zrobione w `KAPSULA.md`.**

**D05. Nazwy katalogów są fikcyjne, a nazwać trzeba w piątek.**
`2-BUILD.md:43-47` daje `w1-detekcja-anomalii` itd.; `3-CHEATSHEET.md:23` każe nazwać
je w piątek, kiedy tematu nie ma.
**Co zrobić:** nazewnictwo przenieść na **0:55**, gdy kapsuła jest wypełniana.
Seed używa `w1-kawalek` … `w5-kawalek` + instrukcji `git worktree move`, gdy
realne nazwy padną. W `seed/repo-layout.md` są komendy.

**D06. `STAN: BUILD` w szablonie, który wczytuje się przed ogłoszeniem tematu.**
`AGENTS.md:31-35` ma wartości dla soboty 13:00, a stany `RESEARCH`/`BRAINSTORM`/
`WYBOR` (`AGENTS.md:43-47`) są o 0:00–0:58 — ten sam plik wczytuje system-1 i agent
systemu-2. Skopiowany 1:1 zostawia sesję przed T0 z *„pełna pętla, kod"*.
**Co zrobić:** seed generuje `AGENTS.md` z `STAN: PRZYGOTOWANIE` i notką, że przed
T0 nie budujesz. **Zrobione w `seed/templates/AGENTS.md`.**

**D07. `research/` jest niewidoczne z worktree agenta.**
`1-RESEARCH.md:77` każe pisać do `research/`, `AGENTS.md:141` każe czytać
`research/*.md`, `2-BUILD.md:216` na sync robi `ls research/`. Ale agent pracuje
na branchu `w3` — `research/` commituje system-1, więc w worktree agenta go nie ma.
Nikt nie napisał, na jakim branchu ono żyje.
**Co zrobić:** system-1 commituje `research/` na `main` przed startem systemu 2
(0:55), a agent czyta przez `git show origin/main:research/01-x.md` — nie edytuje,
nie klonuje, nie wychodzi z katalogu. **Do dopisania w `KAPSULA.md` lub
`AGENTS.md` — zostawione, bo to decyzja zespołu o gałęziach, nie o seedzie.**

**D08. Piątkowy smoke test wymaga `gh` i `jq`.**
`3-CHEATSHEET.md:13-16` używa `gh api .../collaborators --jq`, `gh api .../protection`,
`git ls-remote`. `gh` + `jq` to dwie zależności, których nie ma; `git ls-remote HEAD`
sprawdza czytelność, nie prawo zapisu.
**Co zrobić:** podmienić na `git push origin <branch> --dry-run` — to sprawdza
uprawnienia dokładnie i potrzebuje tylko git. Ochronę `main` sprawdzić w GUI.
**Nie zrobione — `3-CHEATSHEET.md` to zegar dla człowieka, a HANDOFF §5 zabrania
dodawać zależności.**

**D09. `git worktree add -b w3` wybucha, gdy branch już istnieje.**
To realny błąd idempotentności: kolega wpiął się wcześniej, ty odpalasz bootstrap
i dostajesz *„a branch named 'w3' already exists"*. Sprawdziłem na żywo.
**Co zrobić:** bootstrap sprawdza `git show-ref --verify refs/heads/$branch` i
attachuje istniejący branch zamiast `-b`. **Zrobione w `seed/bootstrap.sh:93-96`.**

**D10. Idempotentność psuł `git worktree list` + string match (macOS `/tmp` → `/private/tmp`).**
Pierwsza wersja bootstrapa sprawdzała `grep -q "^worktree $target$"` na wyjściu
`git worktree list --porcelain`. Na macOS git rozwiązuje ścieżkę, więc wzorzec
nigdy nie pasował — drugi run próbował dodać istniejące worktree i rzucał
*„already exists"*. Sprawdzone na żywo.
**Co zrobić:** sprawdzanie przez `[ -e "$target/.git" ]` (worktree ma plik `.git`,
nie katalog). **Zrobione w `seed/bootstrap.sh:87-91`.**

---

## Przetestowane na żywo, ale nieprawdziwe (zapisane, żeby ktoś nie powtórzył)

- **Squash merge nie psuje `merge-base --is-ancestor`.** Sprawdziłem: po
  `git merge --squash w1` commit w1 **nadal jest przodkiem** main. Czyli wzór
  czekania z `2-BUILD.md:137` działa też po squashach. Nie trzeba tego naprawiać.
