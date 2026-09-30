# 05 — Pieść na sobotę

Do wydrukowania. Jedna strona na osobę. Reszta jest w [`03`](03-SYSTEM-RESEARCH.md)
i [`04`](04-SYSTEM-PRODUKCJA.md).

---

## Piątek wieczór — 30 minut

Trzynaście rzeczy. Wszystkie odwracalne. Robimy tylko po to, żeby sobotę nie
zmarnować na setup.

```bash
# 1. kto ma prawo pisać do repo — D5
gh api repos/<org>/<repo>/collaborators --jq '.[].login'          # → lista
gh api repos/<org>/<repo>/branches/main/protection               # → 403? main nie jest chroniony

# 2. działa konto i push
git ls-remote <repo> HEAD && echo OK

# 3. działa agent
claude -p "wymyśl i wydrukuj 3 pytania o mojej bazie kodu"        # → jeśli nie odpowiada, nie jedź

# 4. istnieje jeden działający check.sh (D3) — tylko dla JEDNEGO workstreamu, reszta w sobotę
mkdir -p w1 && printf '#!/usr/bin/env bash\necho OK\n' > w1/check.sh && chmod +x w1/check.sh
bash w1/check.sh && echo "CHECK DZIAŁA"
```

Do zrobienia **ręcznie**, 15 minut z zespołem:

- [ ] **Mózg** wybrany — jedna osoba, jeden laptop, naładowany, podłączony
- [ ] **Merge-owner** wybrany + **wariant awaryjny** wybrany (nie „ktoś, kto może")
- [ ] **Granice 5 workstreamów** narysowane na kartce (D2) — pięć katalogów, zero
      wspólnych plików
- [ ] **Jeden `check.sh` napisany i przetestowany** (D3)
- [ ] **D-liczba** wpisana w `CLAUDE.md` i **wydrukowana**
- [ ] `CLAUDE.md` poniżej 200 linii

**Czego piątek NIE zawiera:** rejestru śmieci, checklisty, planu faz, przeglądu
architektury, drugiego schematu, wyboru modeli per rola. To jest praca na dni.
Zrobienie jej w piątek oznacza, że sobotę budujecie system, a nie rozwiązanie.

---

## Sześć liczb

Wpisane w `CLAUDE.md`, wydrukowane, **wypowiedziane na głos na starcie**. Propozycje
do obalenia — to nie są prawdy, to są wartości startowe.

| # | Co | Propozycja | Dlaczego tyle |
|---|---|---|---|
| 1 | Push co | **30 min** i zawsze przed snem | tyle tracisz, gdy laptop padnie |
| 2 | Sync zespołu co | **2 h**, 5 min na stojąco | mniej = ludzie w złym kierunku, więcej = gadanie |
| 3 | **Freeze** ile godzin przed deadlinem | **4 h** | pełny test + próba demo + pakiet |
| 4 | Review co | **każdy PR** | ~2 min, nie warto ciąć jako pierwszego |
| 5 | Sync nocny | **co noc, 1 wyznaczona osoba** | ktoś musi przyjmować pytania |
| 6 | Wysyłka ile minut przed deadlinem | **90 min** | bufor na zepsutą formularz / kanał organizatora |

**Jeśli któraś nie ma sensu w waszym scenariuszu — powiedzcie to teraz, nie w sobotę.**

---

## Sobota

```
GODZ.  CO SIĘ DZIEJE                                  KTO
─────────────────────────────────────────────────────────────────────────────
-1:00  Setup na miejscu. Klony, loga, jeden test      wszyscy
       na pustym projekcie. NIE research.
                                                    ─── STOP. 60 min na to ───

 0:00  TEMAT OGŁOSZONY
       → Mózg startuje research (limit 90 min)        Mózg
       → wszyscy robią setup, testy, CLI, klony        pozostali 4
                                                    ─── RÓWNOLEGLE ───

 1:30  BRIEF v1 czytany NA GŁOS, 15 minut
       pytanie do zespołu: "gdybyśmy mieli połowę
       czasu, co odcinamy?" → wpisujemy do BRIEF
       lead zatwierdza → ZAMROŻONY
                                                    wszyscy (stoimy/siedzimy)

 1:45  Każdy bierze swój workstream ze speca.
       Robi check.sh dla swojego, zanim napisze
       JEDNĄ LINIJKĘ kodu.
                                                    każdy solo

 2:00  >>> PĘTLA, do freeze <<<

       pracujesz → ./check.sh → commit → push
       otwierasz PR → review (2 min) → merge-owner
       co 2 h: 5 min stojąco
                                                    każdy + merge-owner

 4 h    >>> FREEZE <<<
       lead ogłasza na głos
       każdy kończy na zielonym teście albo jest
       oznaczony CUT — nic pośrodku
                                                    wszyscy

 3 h    pełny test na main
       próba demo RAZ, na zegar
                                                    wszyscy

 2 h    pakiet: link do zamrożonego SHA + instrukcja
       >>> TEST INSTRUKCJI: ktoś, kto nic nie
       budował, klonuje i uruchamia <<<
                                                    1 osoba (ta, która
                                                    NIE budowała)

 1.5h  wysyłka + potwierdzenie (screen/mail/coś)
                                                    merge-owner

 0:00  STOP
```

---

## Noc

- **zmianowość, nie kolejność.** Ktoś śpi, ktoś pracuje. Nie „wszyscy śpią do 6".
- **Przed snem: push.** Bez wyjątków. To jedyna reguła, której nie da się
  zmechanizować i jedyna, która realnie chroni pracę.
- **Jedna osoba na nogach, imiennie.** Przyjmuje pytania. Ktoś musi.
- **Jeśli nikt nie może zostać — powiedzcie to na głos.** Wtedy nocny sync jest
  pominięty, nie „odwołany". Cisza jest gorsza od pominiętego kroku.

---

## Cztery sytuacje, w których się zatrzymacie

Nie plan awarii. Plan **zatrzymania**. Bo każda z tych sytuacji kosztuje więcej
niż 5 minut zgłoszenia i mniej niż dwie godziny cichego złego kodu.

| Sytuacja | Co robić |
|---|---|
| **Brief jest zły** — „moment, to nie jest to zadanie" | STOP. To jest jedyny moment, w którym ktoś może to zobaczyć. Nie czekaj na pewność. |
| **Test nie da się napisać** | STOP. Workstream bez testu to zgadywanie. Poproś o pomoc, nie o „postaram się". |
| **Trzeba ruszyć cudzy katalog** | STOP. Dzielcie katalog albo zmieniacie interfejs w specu (numerowana poprawka). |
| **Nie wiem, czy to działa** | STOP. Uruchom `check.sh`. Jeśli nie istnieje — napisz go. Teraz. |

---

## Czego nie robimy

- **Nie czytamy 348 KB.** Poprzednia wersja dokumentacji — [`AUDYT.md`](AUDYT.md)
  mówi dlaczego. Jeśli ktoś chce, niech poczyta w sobotę. Nikt nie będzie.
- **Nie budujemy rejestru śmieci, checklisty 77 punktów ani 18 stałych.** To jest
  praca na dwa dni. Robienie jej w sobotę = zamiana 24 godzin budowania na 24 godziny
  opisywania budowania.
- **Nie budujemy drugiego schematu.** Jest jeden, prosty, obok.
- **Nie ufamy briefowi, który ma 8 stron.** Jeśli nie mieści się na kartce A4,
  to nie jest brief.
- **Nie mergujemy „bo jest późno".** Po freeze wchodzą tylko defekty blokujące demo,
  każdy z jednozdaniowym powodem w PR. Bez wyjątków — to jest jedyna zasada, która
  jest napisana w pięć plikach po to, żeby była jedna.
- **Nie pozwalamy merge-ownerowi zniknąć o 4:00.** Wariant awaryjny nazwany w piątek,
  nie w szoku.

---

## Jedno zdanie

> **Jeden dokument, jeden człowiek na kawałek kodu, jeden test, który mówi „działa",
> jeden człowiek przy merge, i jasne informowanie, że review można pominąć.**

Wszystko inne w tym repo to uzasadnienie tego zdania i pytania, na które nie
odpowiadamy za was.
