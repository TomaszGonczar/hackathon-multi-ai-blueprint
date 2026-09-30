# 2 — System budowy

**Wejście:** [`KAPSULA.md`](KAPSULA.md) wypełniony. Nic innego.
**Wyjście:** rozwiązanie na `main`, przetestowane przez kogoś, kto nic nie budował.
**Kto:** pięć osób, pięć laptopów, OMP na każdym. Opcjonalnie kolejne sesje
do review.
**Pętla:** **non-stop.** Maszyna wpuszcza na `main`, czeka na moduły, rozwiązuje
 mechaniczne konflikty i nigdy nie blokuje zespołu pytaniem.
> **Reguły operacyjne są w [`AGENTS.md`](AGENTS.md) §4.** Ten plik jest uzasadnieniem
> — *dlaczego* reguła jest taka, a nie inna. Jeśli tu i tam jest rozbieżność,
> **wygrywa `AGENTS.md`**, bo to on jest w kontekście agenta.

**Nie ma tu:** własnego harnessa, orkiestracji, hooków, konfiguracji, bota merge.
**OMP jest runtime. Merge jest regułą w pętli agenta, nie osobnym programem.**

---

## Start: 20 sekund na osobę

```bash
cd ~/w3-modele        # swój katalog, swój worktree
claude
```

Pierwsze zdanie do agenta:

> **Przeczytaj `KAPSULA.md`. Potem uruchom `./w3/check.sh`. Potem zacznij.**

Kolejność jest ważna: **test przed pierwszą linią kodu.** Agent, który najpierw
napisze kod i dopiero potem sprawdzi test, zużyje kontekst i pół nocy na
poprawianie tego, co miał zrobić od razu.

Jeśli `check.sh` nie istnieje — **nie zaczynaj.** Napisz go, albo poproś kogoś,
kto może. To 15 minut, które oszczędzają dwie godziny.

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
   niż brak testu — daje fałszywy spokój.
2. **Punkt 4 działa zawsze**, nie wymaga nikogo o pamiętanie.
3. **`set -euo pipefail` + `exit 1` wszędzie.** Bez tego skrypt, który ma za mało
   sprawdzeń, wraca z 0.

**Przed startem:** zepsujcie jeden kawałek na złoto i upewnijcie się, że `check.sh`
to zauważa. Jeśli nie — test jest zepsuty.

### Reguła

> **Nie ma zielonego `check.sh` — kawałek nie startuje.**
>
> **Zielony `check.sh` i zielony review — kawałek wjeżdża na `main`.**

Powiedzcie to agentowi wprost: *„nie kończ, dopóki `./w3/check.sh` nie wyjdzie 0,
potem review, potem wjeżdżaj na `main` sam"*.

Mechanizm, dla którego to istnieje:

> *„Without a check it can run, 'looks done' is the only signal available, and **you
> become the verification loop: every mistake waits for you to notice.**"*
> — [Claude Code](https://code.claude.com/docs/en/best-practices)

---

## Merge: maszyna, non-stop

**To jest sedno tego systemu. Przeczytaj zanim zaczniesz.**

Reguła jest jedna i agent dostaje ją w instrukcji na starcie. Nie ma bota, nie ma
skryptu, nie ma crona — **każdy agent robi to sam, w swojej pętli**, zaraz po
zielonym teście.

### Czeka na inne moduły

Tabela w kapsule ma kolumnę **„Czeka na"**. To kolejność wjeżdżania na `main`
i jest czytana dosłownie.

Kawałek 4 czeka na 1 i 2. Znaczy: `w4` nie wjeżdża na `main`, dopóki `w1` i `w2`
tam nie będą. **Nie pyta o to.** Sprawdza, nie wjeżdża, wraca do pracy nad swoim
kawałkiem, sprawdza ponownie za jakiś czas.

```bash
# co agent robi zamiast pytać
git fetch origin main
for dep in 1 2; do
  git merge-base --is-ancestor origin/w$dep origin/main || {
    echo "czekam na w$dep — wracam do pracy"
    sleep 600; continue 2
  }
done
```

**Czeka bez końca i nie przeszkadza.** To jest cały sens: kawałek 4 wjeżdża w
sekundzie, w której wjeżdzie ostatni z jego zależności — nawet jeśli to jest trzecia
nad ranem, i nawet jeśli wy śpicie.

**Sprawdźcie na kartce, czy da się ułożyć te pięć kawałków bez cyklu.** Cykl to
deadlock: maszyna czeka w nieskończoność i nic o tym nie wie. To jedyny błąd,
który w tej konstrukcji kosztuje całą noc.

### Konflikty

| Rodzaj konfliktu | Co robi maszyna |
|---|---|
| **Mechaniczny** — importy, kolejność, inne linie w tym samym pliku | **rozwiązuje sama** i wjeżdża |
| **W pliku interfejsu** — plik wymieniony w kapsule jako wspólny | **NIE rozwiązuje.** Zapisuje, nie rusza, wraca do pracy, raport na sync |

Granica jest zapisana w kapsule i agent jej nie zmyśla. Dzięki temu maszyna nigdy
nie rozwiąże po cichu konfliktu, który zmienia kontrakt między kawałkami.

### Co maszyna **nigdy** nie robi

- nie wjeżdża z czerwonym `check.sh`
- nie wjeżdża, jeśli review zgłosił brak w poprawności
- nie rusza plików interfejsu
- nie wjeżdża na `main` przed swoimi zależnościami
- nie zatrzymuje innych kawałków

**Pętla się nie zatrzymuje.** Jeśli twój kawałek nie może wjechać, robisz dalej
swoją robotę i wjeżdżasz później.

---

## Review: świeży kontekst

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
uwagi, bo go o to poproszono, i będziecie je śledzić, budując abstrakcje do rzeczy,
które nie mogą się zdarzyć.

**Trzeci agent „złośliwy"** — *„co by się zepsuło, gdyby ktoś to zaatakował"* — łapie
to, czego dwaj inni nie zauważą. W projekcie security ta trzecia sesja jest bardziej
warta niż gdziekolwiek indziej.

**Kolejność jest sztywna:** merge czeka na review. Nigdy odwrotnie.

---

## Dwa momenty, w których wchodzi człowiek

Nie „człowiek w pętli". Dwa punkty, reszta jest maszynowa.

### Sync — co 2 godziny, 5 minut na stojąco

Człowiek wchodzi, żeby zobaczyć stan, nie żeby coś zrobić:

```bash
git log --oneline main | head -20     # co wjechało
ls research/                          # co research wyciągnął
```

- kto utknął na czekaniu i **dlaczego** (krytyczne — czekający bez powodu to martwy
  kawałek, nie śpiący)
- kto zgłosił konflikt w pliku interfejsu
- czy coś w kapsule trzeba dopisać

**To jedyne miejsce, w którym zespół może świadomie zmienić kolejność mergów.**
Trzy minuty, na kartce, i wpis w tabelę kapsuły.

### Freeze — 4 godziny przed deadlinem

Tu już jest twardo: **każdy kawałek kończy na zielonym teście albo jest oznaczony
CUT.** Nic pośrodku. Cut = wypadnięcie z `main`, nie „dokończymy rano".

Po freeze wchodzą **tylko defekty blokujące demo**, każdy z jednozdaniowym
powodem w PR.

### Odpowiedzialność

Tu jest granica, której nie da się zautomatyzować, i warto powiedzieć ją na głos
przed startem:

> **Maszyna może wjechać wszystko. Nie może powiedzieć, co wysyłacie.**

Slajd IBM-a z 1979, który cytuje Simon Willison, nie zmienia się przez to, że merge
jest automatyczny: *„A computer can never be held accountable. Therefore a computer
must never make a management decision."* Pytanie brzmi tylko, **gdzie** człowiek
wchodzi — i odpowiedź brzmi: tam, gdzie decyduje się, co jest ważne, a nie gdzie
przesuwa się kod. Dlatego dwa momenty, nie bramka przy każdym merge'u.

---

## Co kawałek robi, kiedy utknie

Nie ma sytuacji, w której zespół stoi. Każdy agent:

1. **Zapisuje fakty** — co, kiedy, jaka komenda, jaki wynik
2. **Oznacza w kanale** jedną linią, np. `w3: czekam na w1 i w2, `check.sh` zielony
3. **Wraca do pracy nad tym, co może** — poprawia, pisze testy, dokańcza
4. **Pyta tylko wtedy**, gdy jedno z dwóch: konflikt w pliku interfejsu albo
   kapsuła okazała się zła

Ostatni punkt — kapsuła może źle zrozumieć temat i **żaden mechanizm tego nie
wykryje.** Jeśli ktoś mówi *„moment, to nie jest to, o co chodzi"* — to jest
najważniejszy głos w całym systemie i nie wolno go zignorować. Dlatego to jest
jedyne pytanie, które idzie do człowieka natychmiast, a nie na sync.

---

## Czego tu **nie ma**

- **Bota merge.** Merge jest regułą w pętli agenta, nie osobnym programem.
- **Własnego harnessa.** OMP już jest. Żadnej orkiestracji, żadnych hooków,
  żadnej konfiguracji.
- **Pamięci i wznawiania sesji.** Dwa dni. Nowa sesja czyta kapsułę i ma wszystko.
- **Walidacji stanów, rejestrów, premortemów.** Twierdzenie bez komendy nie istnieje —
  i to jest cała reguła dowodowa.
- **Dziewięciu ról.** Dwa nazwiska. Reszta to funkcja przy okazji.
