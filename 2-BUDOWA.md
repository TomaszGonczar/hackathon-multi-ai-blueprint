# 2 — System budowy

**Wejście:** [`KAPSULA.md`](KAPSULA.md) wypełniony. Nic innego.
**Wyjście:** działające rozwiązanie na `main`, przetestowane przez kogoś, kto nic
nie budował.
**Kto:** pięć osób, pięć laptopów, OMP na każdym. Opcjonalnie pięć drugich sesji
do review.
**Nie ma tu:** własnego harnessa, orkiestracji, hooków, konfiguracji. **OMP jest
runtime. My piszemy pliki i klikamy merge.**

---

## Start: 20 sekund na osobę

```bash
cd ~/w3-modele        # swój katalog, swój worktree
claude
```

Pierwsze zdanie do agenta:

> **Przeczytaj `KAPSULA.md`. Potem uruchom `./w3/check.sh`. Potem zacznij.**

Kolejność jest ważna: **test przed pierwszą linią kodu.** Agent, który najpierw napisze
kod i dopiero potem sprawdzi test, zużyje kontekst i pół nocy na poprawianie tego,
co miał zrobić od razu.

Jeśli `check.sh` nie istnieje — **nie zaczynaj.** Napisz go, albo poproś kogoś, kto
może. To 15 minut, które oszczędzają dwie godziny.

---

## Katalogi: kolizja jest niemożliwa, bo nie ma powierzchni

```bash
# raz, przy starcie
git clone <repo> && cd repo
git worktree add ~/w1-detekcja-anomalii -b w1
git worktree add ~/w2-api             -b w2
git worktree add ~/w3-modele          -b w3
git worktree add ~/w4-reporting       -b w4
git worktree add ~/w5-demo            -b w5
```

Pięć katalogów, pięć branchy, zero wspólnych plików. Nikt nie może pisać do cudzego
katalogu — nie dlatego, że zabroniliście, tylko dlatego, że go nie ma.

**Nazwij katalogi tak, żeby z nazwy było widać zawartość.** Nazwa katalogu to sygnał,
który agent czyta zanim otworzy plik — foldery i nazwy plików to dla niego informacja,
nie kosmetyka.
([źródło](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents))

`w1/` nie mówi nic. `w1-detekcja-anomalii/` mówi wszystko.

---

## Test: jedyna rzecz, bez której to nie działa

```bash
#!/usr/bin/env bash
# ./w3/check.sh — exit 0 = gotowe
set -euo pipefail
cd "$(dirname "$0")/.."

echo "== 1. kompiluje się =="
python -m compileall -q src/modele/ || exit 1

echo "== 2. testy jednostkowe =="
pytest tests/test_modele.py -q || exit 1

echo "== 3. CZY COŚ ŁAPIE =="
python -m demo.replay tests/fixtures/atak.log | grep -q "ALERT" || {
  echo "FAIL: test nie wykrył ataku z fixture — test nic nie sprawdza"
  exit 1
}

echo "== 4. brak sekretów =="
git diff --cached | grep -nEi '(api[_-]?key|password)[[:space:]]*=' && { echo "FAIL: sekret"; exit 1; }

echo OK
```

Trzy rzeczy, których prostszy skrypt nie zrobi:

1. **Punkt 3 sprawdza, że test coś łapie.** Test zielony i bezwartościowy jest gorszy
   niż brak testu — daje fałszywy spokój. Trzy linijki, a zamykają całą klasę błędów.
2. **Punkt 4 działa zawsze**, nie wymaga nikogo o pamiętanie.
3. **`set -euo pipefail` + `exit 1` wszędzie.** Bez tego skrypt, który ma za mało
   sprawdzeń, wraca z 0.

**Przed startem:** zepsujcie jeden kawałek na złoto i upewnijcie się, że `check.sh`
to zauważa. Jeśli nie — test jest zepsuty.

### Reguła

> **Nie ma zielonego `check.sh` — kawałek nie startuje.**

Agent ma prawo zatrzymać się dopiero po zielonym teście. Powiedzcie mu to wprost:
*„nie kończ, dopóki `./w3/check.sh` nie wyjdzie 0"*.

Mechanizm, dla którego to istnieje, cytat dosłowny:

> *„Without a check it can run, 'looks done' is the only signal available, and **you
> become the verification loop: every mistake waits for you to notice.**"*
> — [Claude Code](https://code.claude.com/docs/en/best-practices)

---

## Pętla jednej osoby

```bash
# pracujesz tak, aż test jest zielony
./w3/check.sh

# commitujesz po każdym zielonym teście, nie na koniec dnia
git add -A && git commit -m "w3: <co>"
git push

# review i merge — robi człowiek
```

**Push co 30 minut i zawsze przed snem.** Jeśli laptop padnie o 4:00, tracisz
30 minut pracy zamiast dwunastu. To jedyna reguła, której **nie da się**
zmechanizować — zostaje tekstem i jednym przypomnieniem na głos przy każdym
wyjściu od laptopa.

---

## Review: drugi agent, świeży kontekst

**To jest miejsce, na które wydajemy zakład.** Mamy compute. Warto.

```bash
git diff main...w3 | claude -p "Review this diff against KAPSULA.md in this repo.
Report only gaps that affect correctness or the stated kapsula.
Ignore style, naming, refactoring preferences.
If it works, say so — do not invent problems."
```

Dlaczego to działa lepiej niż recenzja w tej samej sesji:

> *„**A fresh context improves code review since Claude won't be biased toward code it
> just wrote.**"*
> *„A reviewer running in a fresh subagent context **sees only the diff and the criteria
> you give it, not the reasoning that produced the change**."*
> — [Claude Code](https://code.claude.com/docs/en/best-practices)

Zdanie po „If it works, say so" **jest obowiązkowe.** Bez niego recenzent zwróci
uwagi, bo go o to poproszono — i będziecie je śledzić, budując abstrakcje do rzeczy,
które nie mogą się zdarzyć. Cytat:

> *„A reviewer prompted to find gaps will **usually report some, even when the work is
> sound**… chasing every finding leads to over-engineering."*

**Trzeci agent „złośliwy"** — to samo, z promptem *„co by się zepsuło, gdyby ktoś to
zaatakował"* — łapie to, czego dwaj inni nie zauważą. To jest projekt security, więc
ta trzecia sesja jest bardziej tu warta niż gdziekolwiek indziej.

---

## Merge: człowiek, zawsze

Nie „bo AI nie powinno". Uzasadnienie jest twardsze — slajd IBM-a z 1979, cytowany
przez Simona Willisona:

> *„**A computer can never be held accountable. Therefore a computer must never make a
> management decision.**"*

Merge jest decyzją zarządczą: co wchodzi, w jakiej kolejności, co odpada.

**Jedno nazwisko. I jedno nazwisko awaryjne, wybrane w piątek** — nie „ktoś, kto akurat
może". Najbardziej prawdopodobna pojedyncza awaria tego dnia to merge-owner, który
zasypia o 4:00.

Po freeze wchodzą **tylko defekty blokujące demo**, każdy z jednozdaniowym powodem
w PR. Bez wyjątków.

---

## Cztery momenty, w których się zatrzymujecie

Nie plan awarii — **plan zatrzymania.** Każdy kosztuje 5 minut zgłoszenia
i oszczędza dwie godziny cichego złego kodu.

| Sytuacja | Co robić |
|---|---|
| Test nie da się napisać | STOP. Kawałek bez testu to zgadywanie. |
| Trzeba ruszyć cudzy katalog | STOP. Podzielcie katalog albo dopiszcie do sekcji 5 kapsuły. |
| Kapsuła okazała się zła | STOP i powiedzcie na głos. To jest **jedyny** moment, w którym ktoś to zauważy. |
| Nie wiesz, czy działa | STOP. Uruchom `check.sh`. |

Szczególnie trzeci punkt: **kapsuła może źle zrozumieć temat i żaden mechanizm tego
nie wykryje.** Jeśli ktoś w trakcie budowania mówi *„moment, to nie jest to, o co
chodzi"* — to jest najważniejszy głos w całym systemie i nie wolno go zignorować.

---

## Czego tu **nie ma**

- **Własnego harnessa.** OMP już jest. Żadnej orkiestracji, żadnych hooków,
  żadnej konfiguracji.
- **Pamięci i wznawiania sesji.** Dwa dni. Nowa sesja czyta kapsułę i ma wszystko.
- **Walidacji stanów, rejestrów, premortemów.** Twierdzenie bez komendy nie istnieje —
  i to jest cała reguła dowodowa.
- **Dziewięciu ról.** Dwa nazwiska. Reszta to funkcja przy okazji.
