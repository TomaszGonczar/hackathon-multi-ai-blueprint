# 04 — System produkcyjny

**Cel:** pięć osób, pięć agentów, jedno repo, zero kolizji, jeden test na workstream
i jeden człowiek przy merge. W 20 godzin, z 8 godzinami snu w środku.

**Zakres:** godzina 1.5 → wysłanie.

---

## Cztery elementy systemu

Cała reszta to konfiguracja. Są cztery:

1. **Spec** — cztery sekcje, pisany przez agenta, pytającego człowieka
2. **Test** — jedna komenda na workstream, zwracająca 0 albo 1
3. **Worktree** — jeden na osobę, kolizje niemożliwe strukturalnie
4. **Merge** — człowiek, zawsze, z review w świeżym kontekście

Kolejność ma znaczenie: **bez testu nie ma sensu reszty.** (D3)

---

## 1. Spec — cztery sekcje, nie jedenaście pól

Poprzednia wersja miała dziesięciopolowy „Mission Package" (`AUDYT.md` §2 pkt 2),
napisany z myślą, że każde pole musi mieć czytelnika. Poprawna obserwacja, złe
narzędzie — bo pola nie zostały nigdy podłączone do niczego i nikt tego nie zauważył.

Rekomendacja z dokumentacji ([wzorzec B2](01-PATTERNY.md)):

> *„The most useful specs are **self-contained**: they **name the files and interfaces
> involved**, **state what is out of scope**, and **end with an end-to-end verification
> step** that proves the feature works."*

Cztery sekcje. Reszta to gadanie, nie dokument:

```markdown
# SPEC: workstream-3 — detekcja anomalii w logu auth

## Co
Jedno zdanie. Da się obalić.

## Gdzie
Piszę w: src/detect/           Nie ruszam: src/api/, migrations/, SPEC.md innych workstreamów
Interfejs, który konsumuję:      auth.events (given: timestamp, user, ip, action)
Interfejs, który dostarczam:     detect.anomalies(Window) -> [Anomaly]

## Czego NIE robimy
- UI dla tego (ktoś inny)
- Modele ML (za dużo danych, za mało czasu)
- Retries i backoff (nie mamy realnego ruchu)
- Wszystko, co nie jest potrzebne do zielonego testu poniżej

## Jak sprawdzamy
./w3/check.sh    →  exit 0 = gotowe, exit != 0 = nie gotowe
```

Sekcja **„Czego nie robimy"** jest najczęściej pomijana i ratuje najwięcej czasu.
Agent bez niej **zawsze** będzie próbował poprawić sąsiedni kod. To nie jest
przeciążenie — to jest poprawne zachowanie agenta dostającego niepełne zlecenie.

**Kto pisze:** agent, pytając was przez `AskUserQuestion`. **Nie wy** — wy nie macie
pojęcia, jak to zaimplementować, i wasza odpowiedź będzie zgadywanką.
**Która sesja implementuje:** **nowa, czysta.** Ta, która pisała spec, nie implementuje.
Czysty kontekst znaczy, że implementuje to, co spec mówi — a nie to, co pamięta
z rozmowy.

---

## 2. Test — jedyna rzecz, bez której nic nie działa

Mechanizm bez tego jest taki ([wzorzec B1](01-PATTERNY.md)):

> *„Without a check it can run, 'looks done' is the only signal available, and **you become
> the verification loop: every mistake waits for you to notice.**"*

```bash
#!/usr/bin/env bash
# ./w3/check.sh — exit 0 = gotowe
set -euo pipefail
cd "$(dirname "$0")/.."

echo "== 1. czy kod się kompiluje =="
python -m compileall -q src/detect/ || exit 1

echo "== 2. czy testy jednostkowe przechodzą =="
pytest tests/test_detect.py -q || exit 1

echo "== 3. czy to w ogóle łapie atak =="
python -m demo.replay tests/fixtures/bruteforce.log | grep -q "ANOMALY" || {
  echo "FAIL: nie wykryto ataku z fixture — test nic nie sprawdza"
  exit 1
}

echo "== 4. czy nie ma sekretów =="
git diff --cached | grep -nEi '(password|api[_-]?key|token)[[:space:]]*=[[:space:]]*["'"'"']?[A-Za-z0-9]{16,}' && exit 1

echo "OK"
```

**Trzy rzeczy, które ten skrypt robi, których prostszy nie zrobi:**

1. **Punkt 3 sprawdza, że test coś łapie.** Fixture z prawdziwym atakiem musi dać
   alarm. Jeśli nie daje — test jest zielony i bezwartościowy. To jest znany tryb
   awarii („zielony exit code, który nic nie skanował, nie jest dowodem") i wy właśnie
   macie na niego zabezpieczenie za trzy linijki.
2. **Punkt 4 skanuje to, co właśnie commitujecie.** Działa zawsze, nie wymaga nikogo
   o pamiętanie.
3. **`set -euo pipefail` + `exit 1` wszędzie.** Bez tego skrypt, który ma za mało
   sprawdzeń, wraca z 0. Zielony, który nic nie znaczy, jest gorszy od braku testu —
   bo daje fałszywy spokój.

**Reguła, którą warto powiedzieć na głos przed startem:**

> **Nie ma zielonego `check.sh` — workstream nie startuje.**

Nie „postaramy się", nie „później". Jeśli komenda nie istnieje, agent nie wie, kiedy
skończył, wy nie wie, czy działa, i oboje zgadujecie. To jest najdroższa pojedyncza
zmiana, jaką możecie wprowadzić za darmo.

**Reguła na testy wstępne:** zanim napiszecie `check.sh`, zepsujcie swój kod na złoto
i upewnijcie się, że `check.sh` to zauważa. Test, który przechodzi na zepsutym kodzie,
nie jest testem.

---

## 3. Worktree — kolizja jest niemożliwa, bo jest strukturą

```bash
# Raz, przy starcie, każdy na swoim laptopie:
git clone <repo> && cd repo
git worktree add ~/w1 -b w1-detekcja
git worktree add ~/w2 -b w2-api
# ...
```

Pięć katalogów, pięć branchy, zero wspólnej powierzchni do napisania. Nikt nie może
pisać do cudzego katalogu — nie dlatego że zabroniliście, tylko dlatego że go nie ma.

**To nie jest „jedna osoba na jedną powierzchnię". To jest brak powierzchni do konfliktu.**
Poprzednia wersja zaprojektowała tę regułę od zera, nazwała ją najważniejszą i
dodała 19 punktów checklisty, żeby pilnować jej ręcznie. Narzędzie ma ją wbudowaną
([wzorzec B3](01-PATTERNY.md)).

**Nazwij katalogi i branche tak, żeby z nazwy było widać zawartość.** To nie jest
estetyka — nazwa to sygnał, który agent czyta zanim otworzy plik
([wzorzec C3](01-PATTERNY.md)):

- `w1/` `w2/` — nic nie mówi
- `w1-detekcja-anomalii/` — mówi wszystko, bez otwierania

**Push:** co 30 minut i zawsze przed snem. Zapiszcie to jako skrót w `.gitconfig`
albo jako instrukcję w `CLAUDE.md`. Nie da się tego zmechanizować — zostaje tekstem
i jednym przypomnieniem na głos przy każdym wyjściu od laptopa.

---

## 4. Merge — człowiek, review w świeżym kontekście

### Dlaczego człowiek

Nie „bo AI nie powinno". Twardsze uzasadnienie — slajd IBM-a z 1979, cytowany przez
Simona Willisona:

> *„**A computer can never be held accountable. Therefore a computer must never make a
> management decision.**"*

Merge jest decyzją zarządczą: co wchodzi do głównej gałęzi, w jakiej kolejności, co
odpada. Nie ma jej u maszyny. Poprzednia wersja pisała „no AI merges, ever" pięć razy
w pięciu plikach — trafiając w punkt, tyle że bez uzasadnienia, które da się powtórzyć
zespołowi o 4 rano.

**Merge-owner to jedna osoba. Ale wariant awaryjny musi być nazwany na starcie**,
nie w momencie, gdy ten ktoś zaśnie o 3:00. „Ktoś, kto akurat może" to nie jest
wariant awaryjny, to jest brak planu.

### Dlaczego review

> *„**A fresh context improves code review since Claude won't be biased toward code it just
> wrote.**"*
> *„A reviewer running in a fresh subagent context **sees only the diff and the criteria you
> give it, not the reasoning that produced the change**."*
> — [Claude Code](https://code.claude.com/docs/en/best-practices)

Jedna komenda, zero konfiguracji, działa od minuty zero:

```bash
git diff main...w1 | claude -p "Review this diff against SPEC.md in this repo.
Report only gaps that affect correctness or the stated spec.
Ignore style, naming, and refactoring preferences.
If it works, say so — do not invent problems."
```

**Ostatnie zdanie jest obowiązkowe.** Bez niego dostaniecie raport pełen uwag, bo
recenzent został poproszony o raport. Cytat:

> *„A reviewer prompted to find gaps will **usually report some, even when the work is
> sound**… chasing every finding leads to over-engineering."*

**To jest cały zamiennik obserwatora.** Porównanie:

| | Stary obserwator | Świeży recenzent przy merge |
|---|---|---|
| Koszt | proces ciągły + token read-only + laptop, który nie może zasnąć | ~2 minuty, tylko gdy jest co mergować |
| Kto ocenia | ten sam laptop, który napisał plan | inna sesja, nie widzi planu |
| Co raportuje | odchylenia od zamrożonego planu | braki w diffie względem speca |
| Okno bezczynności | musi istnieć jako liczba, inaczej szum albo cisza | nie istnieje — jest merge albo go nie ma |
| Kiedy działa | cały czas, w tym gdy nikt go nie czyta | wtedy kiedy ktoś naprawdę czyta |

Stary obserwator miał trzy nierozwiązywalne problemy opisane w `AUDYT.md` §4. Wszystkie
trzy znikają razem z procesem, bo **nie ma procesu, który mógłby zawieść cicho.**

**Zastrzeżenie, które warto powiedzieć na głos:** ten review jest **pierwszą rzeczą do
odcięcia**, dokładnie tak jak był obserwator. Jeśli w piątek powiecie, że nie zdążacie
— pomijacie review, zostaje zielony test. Kolejność cięcia jest jawna z góry, nie
w momencie paniki.

---

## Repo — struktura jest kontekstem

```
repo/
├── CLAUDE.md              ← do 200 linii. Krótszy = lepiej przestrzegany.
├── BRIEF.md               ← zamrożony, z numerowanymi poprawkami
├── SPEC-w1.md             ← 4 sekcje
├── SPEC-w2.md
├── ...
├── research/              ← pliki z researchu, nie podsumowania
├── w1/  w2/  w3/  w4/  w5/    ← kod, po katalogu na osobę
│   └── check.sh
└── .claude/
    ├── settings.json      ← hooki (patrz niżej)
    └── rules/             ← reguły ładowane tylko dla pasujących plików
```

**Nazwy katalogów są sygnałem.** `w1/` nie mówi nic. `w1-detekcja-anomalii/` mówi
wszystko agentowi, zanim otworzy plik. To jest inżynieria kontekstu, nie estetyka.

**Hooki na trzy obowiązki** (D5). Deterministyczne, w przeciwieństwie do tekstu
w `CLAUDE.md`:

```jsonc
// .claude/settings.json
{
  "hooks": {
    "PreToolUse": [{ "matcher": "Bash", "hooks": [
      {"command": "grep -qE 'api[_-]?key|password' && echo 'STOP: sekret w poleceniu' && exit 2"}
    ]}],
    "Stop": [{ "hooks": [
      {"command": "bash w1/check.sh || echo 'NIE GOTOWE — test nie przeszedl' && exit 2"}
    ]}]
  }
}
```

Hook `Stop` blokuje zakończenie tury, dopóki test nie przejdzie. To jest wersja
wykonywalna zasady „nie ma zielonego testu — nie ma wyniku" — i jednocześnie jest
dokładnie tym, czego poprzednia wersja szukała przez 776 linii własnego censusu.

**Census na żądanie, nie własnym kodem:**

```bash
claude -p "/doctor prompt-audit"
```

Szuka sprzeczności, nieistniejących referencji i instrukcji napisanych dla starszych
modeli. Poprzedni własny census porównywał identyfikatory, nie treść zdań — dlatego
przepuścił żywą sprzeczność opisaną w `AUDYT.md` §3.1. Ta komenda robi dokładnie to,
o co tamten chodziło.

---

## Pętla pracy jednej osoby

```bash
# 1. wejdź do swojego katalogu (czysty kontekst)
cd ~/w1-detekcja-anomalii && claude

# 2. "z implementuj SPEC-w1.md" — agent czyta spec, nie pamięta rozmowy

# 3. agent robi, uruchamia ./check.sh, poprawia, aż przejdzie

# 4. commit + push
git add -A && git commit -m "w1: <co>" && git push

# 5. review + merge (człowiek)
git checkout main && git merge --no-ff w1
```

**Częstotliwość commita:** po każdym zielonym teście, nie na koniec dnia. Powód
jest dosłowny: jeśli laptop padnie o 4:00, tracicie godzinę pracy zamiast dwunastu.
Push przed snem to **ta sama reguła, tylko ważniejsza** — bo po przebudzeniu laptop
jest wyłączony i push już nie pomoże.

**Kiedy zatrzymać się i zapytać:**

- interfejs z `SPEC.md` okazał się zły
- testu nie da się zrobić bez ruszania cudzego katalogu
- `check.sh` nie istnieje, a powinien

Każde z tych pytań **kosztuje 5 minut zgłoszenia i oszczędza dwie godziny cichego
złego kodu.** To nie jest nadgorliwość, to jest rachunek.

---

## Czego ten system **nie** robi

- **Nie pilnuje, żeby budowaliście to, co jest w briefie.** Brief może źle
  zrozumieć temat. Nic tego nie wykryje — poprzedni obserwator też nie, i to był jego
  udokumentowany, nierozwiązywany problem. **To robicie wy, czytając `BRIEF.md` na
  głos w 15 minut.** Jeśli to jedyny moment, w którym ktoś zatrzyma się i powie
  „moment, to nie jest to" — to on jest najważniejszy w całym systemie.
- **Nie mówi, czy pójście było dobrą decyzją.** System jest poprawny niezależnie od tego,
  czy wygracie. To osobna sprawa, i niech nie miesza się z „czy zadziałało".
- **Nie zastępuje wiedzy o tym, co budujecie.** Jeśli ktoś nie rozumie domeny,
  zielony test mówi mu tylko, że kod robi to, co spec kazał. Nie że to jest dobry
  projekt. **Do tego potrzebna jest osoba, która temat rozumie — i dlatego brief
  musi czytać się w 15 minut na głos, a nie w 5 minut na ekranie.**
