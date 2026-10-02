# DEVPLAN.md — od piątku wieczorem do wysłania

**Format:** lista do odhaczenia, nie dokument do czytania. Każdy krok ma
właściciela i warunek przejścia, który widać w terminalu.

**T0** = ogłoszenie tematu. **Wszystko przed T0** to setup.

---

## Piątek wieczór (30 min, razem)

- [ ] **P1. Odpalić seed.** `bash seed/bootstrap.sh`
  Właściciel: każdy na swoim laptopie.
  Warunek: `bash seed/VERIFY.md` zielone (8/8), konczy `OK`.

- [ ] **P2. Remote.** `git -C ~/hackathon-rozwiazanie remote add origin <url>`
  Właściciel: jeden człowiek.
  Warunek: `git push origin main --dry-run` przechodzi. **Bez tego push co 30 min
  nie istnieje, a nocny backup nie istnieje.**

- [ ] **P3. Wybrać system-1.** Jedna osoba, jeden laptop, naładowany.
  Właściciel: zespół na głos.
  Warunek: imiennie zapisane, kto.

- [ ] **P4. Sprawdzić kolejność mergów na kartce — bez cyklu.**
  Właściciel: zespół, 3 minuty.
  Warunek: domyślna tabela z `KAPSULA.md` sekcja 5 (w3→1,2; w4→1,2; w5→1,2,3,4)
  jest acykliczna. **Jeśli ją zmieniacie, nie wracacie spać, dopóki nie
  dorysujecie grafu bez cyklu.**

- [ ] **P5. Imienne osoby na noc.** Kto zostaje na nogach.
  Właściciel: zespół.
  Warunek: zapisane, i jeśli nikt nie może — **powiedziane na głos**, a nie
  pominięte po cichu.

**Piątek NIE zawiera:** pisania prawdziwego `check.sh`, zgadywania tematu,
checklisty, wyboru języka. `check.sh` ma `PHASE=0` i to jest zielone.

---

## Sobota 08:50 — przed T0

- [ ] **S1. Weryfikacja seeda na każdym laptopie.** `bash seed/VERIFY.md`
  Właściciel: każdy.
  Warunek: 8/8 zielone. Czerwone = nie zaczynamy.

- [ ] **S2. Push smoke test.** `git push origin main --dry-run`
  Właściciel: każdy.
  Warunek: przechodzi. Nie przechodzi = P2 nie zrobiony, nie ruszamy dalej.

- [ ] **S3. Faza 0 `check.sh`.** `cd ~/wN-kawalek && $EDITOR check.sh`
  Właściciel: każdy.
  Warunek: `./check.sh` kończy 1 z komunikatem o fazie 0 (to cel).
  **Nie wypełniamy sekcji 1–3** — jeszcze nie wiemy, co budujemy.

---

## Sobota T0 — T+0:35 (research)

- [ ] **R1. System-1: 5 sesji równolegle, każda do `research/NN-nazwa.md`.**
  Właściciel: system-1.
  Warunek: 5 plików w `research/`, każdy ma sekcje *Ustalone / Niespójne /
  Nie udało się ustalić / Dalej* (wzór w `1-RESEARCH.md:91-105`).

- [ ] **R2. Reszta: nie czekamy.** Każdy kończy fazę 0 `check.sh`.
  Właściciel: pozostali czterej.
  Warunek: `./check.sh` na każdym katalogu kończy 1 (faza 0) — **to jedyny
  moment, w którym 1 jest poprawnym wynikiem.**

---

## Sobota T+0:35 — T+0:58 (brainstorm i wybór)

- [ ] **B1. System-1: 3 sesje (pragmatyk, sceptyk, outsider), równolegle.**
  Właściciel: system-1.
  Warunek: 3 propozycje na stole.

- [ ] **B2. ZESPÓŁ WYBIERA na głos.** 5 minut.
  Właściciel: wszyscy.
  Warunek: **jedna nazwa wybrana**. Brak wyboru = nie startujemy. To jest brama.

- [ ] **B3. System-1 wypełnia kapsułę.** `KAPSULA.md`, 6 sekcji.
  Właściciel: system-1.
  Warunek: sekcja 5 wypełniona — **pięć kawałków z kolumną „Czeka na"** i lista
  plików interfejsu. Bez tej kolumny maszyna stoi w nocy i pyta człowieka.

- [ ] **B4. System-1 commituje `research/` i `KAPSULA.md` na `main`.**
  Właściciel: system-1.
  Warunek: `git show origin/main:research/01-x.md` działa z worktree agenta.
  Patrz D07 — bez tego nikt nie przeczyta researchu.

- [ ] **B5. Każdy zmienia nazwy katalogów, jeśli kapsuła je podaje.**
  Właściciel: każdy.
  Warunek: `git worktree move` + `git branch -m` wykonane **zanim ktokolwiek
  napisze linię kodu**. Komendy w `seed/repo-layout.md`.

- [ ] **B6. Każdy wypełnia sekcje 1–3 w `check.sh`, `PHASE=1`.**
  Właściciel: każdy.
  Warunek: `./check.sh` kończy 0 i **test coś łapie** (zepsuj kawałek, sprawdź).

---

## Sobota T+1:00 — FREEZE (budowa non-stop)

Pętla każdego agenta, bez końca:

1. `./check.sh` zielone
2. review w świeżym kontekście (`AGENTS.md` §4.5)
3. czy moje zależności są na `main`? (`git merge-base --is-ancestor`)
   - nie → **czekam, wracam do pracy**, sprawdzam za 10 min
   - tak → merge na `main` sam
4. push co 30 min, zawsze przed snem

- [ ] **F1. FREEZE — 4 h przed deadlinem.** Ogłasza lead, na głos.
  Właściciel: lead.
  Warunek: **każdy kawałek ma zielony test albo CUT**. Nic pośrodku.
  CUT = wypadnięcie z `main`, nie *„dokończymy rano"*.

- [ ] **F2. Tylko defekty blokujące demo.** Każdy z jednozdaniowym powodem w PR.
  Właściciel: lead zatwierdza.
  Warunek: nowe funkcje odrzucane bez dyskusji.

---

## Po FREEZE

- [ ] **W1. Pełny test na `main`.** Próba demo RAZ, na zegar.
  Właściciel: wszyscy.
  Warunek: demo przechodzi albo zapisany konkretny brak.

- [ ] **W2. Test instrukcji — 2 h przed deadlinem.**
  Ktoś, kto **NIC NIE BUDOWAŁ**, klonuje repo i uruchamia quickstart.
  Właściciel: jedna osoba, nie budująca.
  Warunek: uruchamia się bez pytania do kogokolwiek.

- [ ] **W3. Wysyłka — 1.5 h przed deadlinem.**
  Właściciel: człowiek.
  Warunek: potwierdzenie zapisane (link, ID, timestamp).

---

## Plan awaryjny — „nie zdążyliśmy zasadzić seedów"

**Objaw:** sobota 08:50, `bootstrap.sh` nie działa albo VERIFY czerwone.

**Nie naprawiamy seeda. Seed jest dla nas, nie dla wyniku.**

1. **Ręczne minimum (10 min):**
   ```bash
   git clone <repo> ~/hackathon-rozwiazanie && cd ~/hackathon-rozwiazanie
   git worktree add ~/w1-kawalek -b w1
   git worktree add ~/w2-kawalek -b w2
   git worktree add ~/w3-kawalek -b w3
   git worktree add ~/w4-kawalek -b w4
   git worktree add ~/w5-kawalek -b w5
   ```
2. **Kapsuła ręcznie:** skopiuj `seed/templates/KAPSULA.md` do roota repo,
   wypełnij sekcję 5 na głos. Reszta może poczekać.
3. **`check.sh` ręcznie:** jeden plik z `set -euo pipefail` i `exit 1`. Lepszy
   czerwony test niż jego brak.
4. **Zasada zostaje:** kolejność mergów musi być acykliczna, zanim ktokolwiek
   startuje. Nawet z palca.

**Jeśli nie ma nawet tego:** każdy pracuje w swoim katalogu na swoim branchu,
merge na koniec ręcznie. Tracicie noc, ale nie tracicie wyniku.

---

## Jeśli temat jest inny niż zakładano

**To nie jest awaria. To jest główne ryzyko i ma swoją sekcję w kapsule (§4).**

1. **Ktoś mówi *„moment, to nie jest to, o co chodzi"* → mówisz natychmiast.**
   Nie na sync, nie po zakończeniu kawałka. `AGENTS.md` §4.8 i `3-PIESC.md:128-129`
   mówią, że to jest najważniejszy głos w systemie i nikt inny go nie wyda.

2. **Kapsuła §4 mówi, czego nie wiemy.** Jeśli brakuje tam tej obawy, dopisz.
   To jest jedyne miejsce, w którym system-1 może was uprzedzić.

3. **Twarda reguła:** **nie zmieniacie wyboru po T+1:00.** System-1 milczy po
   wyborze (`1-RESEARCH.md:7`). Wątpliwość co do *wyboru* to decyzja zespołu na
   **sync**, nie indywidualna zmiana kierunku. Zmiana kierunku przez jedną osobę
   = pięć różnych modeli problemu = dokładnie tryb awarii, który ten system ma
   zlikwidować.

4. **Technologia się nie zgadza:** kapsuła nie przewidziała — piszecie w
   sekcji 4 kapsuły i **jedicie dalej z tym, co jest**. Nie zmieniacie języka
   ani frameworka bez zgody na sync.

5. **Kawałek w kapsule okazuje się niemożliwy:** zgłaszacie na sync, lead
   zmienia sekcję 5, wy przechodzicie na najbliższy możliwy kawałek.
   **Nie wymyślacie sobie podziału sami** — to psuje „Czeka na" i powstaje cykl.

---

## Czego tu nie ma (i dlaczego)

- **Nie powtarza `3-PIESC.md`.** To zegar (kiedy), to kolejność pracy (co, kto,
  warunek przejścia). Nakładają się tylko w FREEZE i wysyłce, bo to są punkty
  styku.
- **Nie ma roli review-bota.** Review robi agent w świeżym kontekście, na
  komendzie z `AGENTS.md` §4.5.
- **Nie ma wyboru modelu.** Każdy używa swojego coding agenta — OMP, Claude Code,
  Codex. Seed tego nie zakłada.
- **Nie ma języka programowania.** Wybór pada w sobotę, `check.sh` jest neutralny.
