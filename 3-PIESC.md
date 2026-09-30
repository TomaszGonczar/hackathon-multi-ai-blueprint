# 3 — Pięść na sobotę

Do wydrukowania. Reszta jest w [`1-RESEARCH.md`](1-RESEARCH.md) i
[`2-BUDOWA.md`](2-BUDOWA.md).

---

## Piątek — 30 minut

Po to, żeby w sobotę nie zmarnować godziny na setup.

```bash
gh api repos/<org>/<repo>/collaborators --jq '.[].login'   # kto może pisać
gh api repos/<org>/<repo>/branches/main/protection        # czy main jest chroniony
git ls-remote <repo> HEAD                                  # działa push
claude -p "wymyśl 3 pytania o tej bazie kodu"              # działa agent
```

Do zrobienia z zespołem, 15 minut:

- [ ] **System-1** wybrany — jedna osoba, jeden laptop, naładowany
- [ ] **Merge-owner** + **wariant awaryjny** nazwane na głos
- [ ] **Jeden `check.sh`** napisany i przetestowany (przynajmniej dla jednego kawałka)
- [ ] **Kapsuła** wydrukowana pusta — w sobotę wypełniacie ją na żywo
- [ ] **Pięć katalogów** wstępnie nazwanych

**Czego piątek nie zawiera:** rejestru śmieci, checklisty, planu faz, przeglądu
architektury, wyboru modeli. To praca na dni. Zrobienie tego = w sobotę budujecie
proces zamiast rozwiązania.

---

## Cztery liczby

Wpisane w kapsule, wydrukowane, **wypowiedziane na głos na starcie.**

| Co | Ile | Dlaczego |
|---|---|---|
| **Push co** | 30 min i zawsze przed snem | tyle tracisz, gdy laptop padnie |
| **Sync zespołu co** | 2 h, 5 min na stojąco | mniej = zły kierunek, więcej = gadanie |
| **Freeze ile godzin przed deadlinem** | 4 h | pełny test + próba demo + pakiet |
| **Wysyłka ile minut przed deadlinem** | 90 | bufor na zepsutą formularz |

**Jeśli któraś nie ma sensu w waszym scenariuszu — powiedzcie to teraz, nie w sobotę.**

---

## Sobota

```
GODZ.  CO                                       KTO
──────────────────────────────────────────────────────────────
-1:00  Setup na miejscu: klony, loga, jeden test
       na pustym projekcie. NIE research.       wszyscy
                                              ── STOP: 60 min ──

 0:00  TEMAT
       → system 1 startuje research             system-1
       → reszta: setup, testy, worktree         pozostali 4
                                              ── RÓWNOLEGLE ──

 1:00  → system 1 przechodzi na brainstorm     system-1
       → reszta KOŃCZY setup i czeka          pozostali 4
       → robią wtedy: własny check.sh          bo i tak muszą

 1:30  → 3 propozycje rozwiązania na głos      wszyscy (10 min)

 1:45  ZESPÓŁ WYBIERA. Na głos.               wszyscy

 2:00  system 1 wpisuje wybór do kapsuły       system-1
       brief czytany NA GŁOS, 15 min
       "gdybyśmy mieli połowę czasu,
        co odcinamy?" → sekcja 6 kapsuły

 2:30  >>> SYSTEM 2 STARTUJE <<<
       każdy: czytaj kapsułę → check.sh → kod   każdy solo

       pętla: kod → check.sh → commit → push
              → review (2 agenty) → merge

              co 2 h: 5 min na stojąco

 4 h    >>> FREEZE <<<                          wszyscy
       lead ogłasza na głos
       każdy: zielony test albo CUT — nic pośrodku

 3 h    pełny test na main                     wszyscy
       próba demo RAZ, na zegar

 2 h    >>> TEST INSTRUKCJI <<<
       ktoś, kto NIC NIE BUDOWAŁ, klonuje
       repo i uruchamia quickstart

 1.5h  wysyłka + potwierdzenie                merge-owner

 0:00  STOP
```

**Uwaga o 1:00–1:30:** system 1 brainstormuje, a cztery osoby **nie czekają** —
piszą swoje `check.sh`. To jedyna godzina w planie, w której coś się marnuje,
i dlatego jest zaplanowana.

---

## Noc

- **zmianowość, nie kolejność.** Ktoś śpi, ktoś pracuje. Nie „wszyscy do 6".
- **Przed snem: push.** Bez wyjątków. Nie da się zmechanizować — to jedyna reguła,
  która realnie chroni pracę.
- **Jedna osoba na nogach, imiennie.** Przyjmuje pytania. Ktoś musi.
- **Jeśli nikt nie może zostać — powiedzcie to na głos.** Wtedy nocny sync jest
  pominięty, nie „odwołany". Cisza jest gorsza od pominiętego kroku.

---

## Czterdzieści sekund wiedzy

Trzy rzeczy, których mechanizm jest taki sam, a mówienie ich zajmuje mniej niż
sekundę:

1. **Nie ma zielonego `check.sh` — kawałek nie startuje.**
2. **Nikt nie pushuje na `main` bez review.** Jeśli nie da się tego zmechanizować,
   powiedzcie to na głos i zapiszcie jako znane ograniczenie — nie jako regułę.
3. **Review można pominąć.** Jeśli nie zdążacie — pomijacie. Kolejność cięcia
   jest jawna **z góry**, nie w momencie paniki.

---

## Czego nie robimy

- **Nie czytamy `archiwum/`.** To audyt starej wersji. Ciekawostka, nie instrukcja.
- **Nie budujemy rejestru śmieci, checklisty 77 punktów ani 18 stałych.** Robienie
  tego w sobotę = zamiana 24 godzin budowania na 24 godziny opisywania budowania.
- **Nie ufamy kapsule, która ma 8 stron.** Jeśli nie mieści się na kartce A4,
  to nie jest kapsuła.
- **Nie pozwalamy merge-ownerowi zniknąć o 4:00.** Wariant awaryjny nazwany w piątek.
- **Nie wracamy do systemu 1 po wyborze.** Jest tam wszystko. Jeśli czegoś brakuje —
  dopisz do sekcji 4 kapsuły i jedź dalej.

---

## Jedno zdanie

> **System 1 bada i podsuwa opcje, wybieracie na głos, system 1 zapisuje wybór w
> jednym pliku, pięć osób buduje z tego pliku w swoich katalogach, jeden człowiek
> merguje.**
