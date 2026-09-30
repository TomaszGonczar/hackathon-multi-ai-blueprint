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
- [ ] **Kapsuła** wydrukowana pusta — w sobotę wypełniacie na żywo
- [ ] **Jeden `check.sh`** napisany i przetestowany
- [ ] **Pięć katalogów** wstępnie nazwanych
- [ ] **Kolejność mergów** wstępnie na kartce — **bez cyklu**

Ostatni punkt jest nowy i ważny: przy maszynowym merge'ach kolejność musi istnieć
**zanim** system 2 wystartuje, bo inaczej maszyna stanie w nocy i nie będzie wiedziała
dlaczego. Patrz kolumna „Czeka na" w [`KAPSULA.md`](KAPSULA.md).

**Czego piątek nie zawiera:** rejestru śmieci, checklisty, planu faz, przeglądu
architektury, wyboru modeli. To praca na dni. Zrobienie tego = w sobotę budujecie
proces zamiast rozwiązania.

---

## Cztery liczby

Wpisane w kapsule, wydrukowane, **wypowiedziane na głos na starcie.**

| Co | Ile | Dlaczego |
|---|---|---|
| **Push co** | 30 min i zawsze przed snem | tyle tracisz, gdy laptop padnie |
| **Sync zespołu co** | 2 h, 5 min na stojąco | tu wchodzi człowiek — jedyne miejsce |
| **Freeze ile godzin przed deadlinem** | 4 h | drugi moment wejścia człowieka |
| **Wysyłka ile minut przed deadlinem** | 90 | bufor na zepsutą formularz |

---

## Sobota

```
GODZ.  CO                                        KTO
───────────────────────────────────────────────────────────────
-1:00  Setup na miejscu: klony, loga, test      wszyscy
       na pustym projekcie.                      ── STOP: 45 min ──

 0:00  TEMAT
       → system 1 startuje research              system-1
       → reszta: KOŃCZY check.sh swojego        pozostali 4
                                                  kawałka
 0:35  system 1 → brainstorm (3 sesje równolegle) system-1

 0:48  ZESPÓŁ WYBIERA opcję, na głos             wszyscy (5 min)

 0:55  system 1 wpisuje do kapsuły               system-1
       brief: "budujemy X, kawałki takie"
                                                  wszyscy (5 min)

 1:00  >>> SYSTEM 2 STARTUJE <<<
       każdy: czytaj kapsułę → check.sh → kod    każdy solo

       ┌─ pętla, non-stop ──────────────────────
       │ kod → check.sh → review → MERGE SAM
       │        │
       │        ├ zależności nie na main → CZEKAJ, wracaj do pracy
       │        ├ konflikt mechaniczny → rozwiąż sam, wjeżdżaj
       │        └ konflikt w interfejsie → ZAPISZ, wracaj, raport
       │
       └─ co 2 h: SYNC, 5 min — tu wchodzi człowiek

 4 h    >>> FREEZE <<<                           wszyscy
       lead ogłasza na głos
       każdy: zielony test albo CUT — nic pośrodku
                                                  (tu drugi raz
                                                   wchodzi człowiek)

 3 h    pełny test na main                       wszyscy
       próba demo RAZ, na zegar

 2 h    TEST INSTRUKCJI
       ktoś, kto NIC NIE BUDOWAŁ, klonuje
       repo i uruchamia quickstart

 1.5h  wysyłka + potwierdzenie                   człowiek

 0:00  STOP
```

**Uwaga o 0:00–0:55:** system 1 pracuje, pozostali nie czekają — robią `check.sh`
swoich kawałków. To jedyny czas, w którym coś się marnuje, i dlatego jest zaplanowany.

**Uwaga o pętli:** maszyna wjeżdża sama przez całą noc. Człowiek wchodzi
**dwa razy** — na sync i na freeze. Nie przy każdym merge'u. To jest kompromis
świadomy: automatyzacja przejmuje wykonanie, człowiek zostaje odpowiedzialny za
to, co wysyłacie.

---

## Noc

- **zmianowość, nie kolejność.** Ktoś śpi, ktoś pracuje. Nie „wszyscy do 6".
- **Przed snem: push.** Bez wyjątków. Nie da się zmechanizować — i przy maszynowym
  merge'u nie ma człowieka, który zauważy, że tego nie zrobiliście.
- **Ktoś zostaje na nogach i imiennie.** Nie po to, żeby mergował — merguje maszyna.
  Po to, żeby ktoś zobaczył, że dwa kawałki czekają od trzech godzin.
- **Jeśli nikt nie może zostać — powiedzcie to na głos.** Sync nocny pominięty,
  nie „odwołany". Cisza jest gorsza od pominiętego kroku.

---

## Trzydzieści sekund wiedzy

1. **Zielony `check.sh` i zielony review = wjeżdżaj na `main`.** Sam, nie pytając.
2. **Czekasz na zależności — czekasz.** Nie pytaj, nie blokuj, wracaj do pracy.
3. **Konflikt w pliku interfejsu — nie ruszaj.** Zapisz i wróć do pracy.
4. **Push co 30 minut i przed snem.** Nikt tego nie sprawdzi poza wami.
5. **Kapsuła może być zła i nic tego nie wykryje.** Jeśli ktoś to widzi — to jest
   najważniejszy głos w systemie. Natychmiast, nie na sync.

---

## Czego nie robimy

- **Nie czytamy `archiwum/`.** To audyt starej wersji. Ciekawostka, nie instrukcja.
- **Nie budujemy rejestru śmieci, checklisty 77 punktów ani 18 stałych.**
- **Nie ufamy kapsule, która ma 8 stron.** Jeśli nie mieści się na kartce A4,
  to nie jest kapsuła.
- **Nie zostawiamy cyklu w kolejności mergów.** Cykl = maszyna czeka w nieskończoność.
- **Nie zatrzymujemy zespołu.** Jeśli twój kawałek utknął, robisz to, co możesz,
  i wjeżdżasz później.

---

## Jedno zdanie

> **System 1 w godzinę bada i podsunie trzy opcje, wybieracie na głos, system 1
> zapisuje wybór w jednym pliku, pięć maszyn buduje z niego w swoich katalogach
> i sama wpuszcza na `main` czekając na moduły, a wy wchodzicie dwa razy — na sync
> i na freeze.**
