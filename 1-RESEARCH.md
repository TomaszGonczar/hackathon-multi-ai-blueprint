# 1 — System researchu i brainstormu

**Wejście:** temat ogłoszony na kartce.
**Wyjście:** [`KAPSULA.md`](KAPSULA.md) wypełniony.
**Kto:** jeden laptop, jeden człowiek, OMP. Reszta zespołu **w tym czasie nie czeka** —
robi swoje `check.sh` ([`2-BUDOWA.md`](2-BUDOWA.md)).
**Stop:** zespół wybrał opcję na głos. Potem system 1 milczy do końca.

**Budżet: 60 minut.** Nie dwa godziny.

---

## Zegar

```
0:00 ──────── 0:35   research: 5 sesji równolegle
                    każda dostaje jedno pytanie, nie temat
                    każda zapisuje do PLIKU, nie gada
                           │
0:35 ──────── 0:48   brainstorm: 3 sesje, 3 różne wejścia
                           │  (pragmatyk · sceptyk · outsider)
                           ▼
0:48 ──────── 0:58   ZESPÓŁ WYBIERA na głos → system 1 wpisuje do kapsuły
                           │
0:58 ──────── 1:00   brief czytany NA GŁOS
                           ▼
                      System 2 startuje
```

**Ciaśno. I to jest cena decyzji, którą podjęliście:** zamiast rozstrzygać temat
lepiej, rozstrzygacie go szybciej i wracacie do niego później, przy budowaniu.
Dlatego sekcja 4 kapsuły („czego nie wiemy") jest wypełniana przez system 1
automatycznie — **nie macie czasu jej zredagować, a wiecie mniej niż on.**
Nie usuwajcie jej. To jest miejsce, w które wyląduje wszystko, czego research
nie zdążył.

---

## Research: 5 sesji w 35 minut

**Dlaczego wiele agentów:** to jedyne miejsce w projekcie, gdzie wiele agentów
naprawdę wygrywa. Anthropic mierzy na swoim eval-u badawczym przewagę **+90,2%**
nad pojedynczym agentem przy pytaniach rozgałęziających się w wiele niezależnych
kierunków. Temat hackathonu jest dokładnie takim pytaniem.
([źródło](https://www.anthropic.com/engineering/multi-agent-research-system))

**Dlaczego pięć, a nie dziesięć:** bo lead musi je przeczytać w 10 minut.
Pięć plików to da się przejrzeć. Dziesięciu nie da się, i zostaje wam **dwadzieścia
plików do przeczytania o 3:00 w nocy** — czyli dokładnie ten tryb awarii, który
cała ta konstrukcja ma zlikwidować.

Przy 35 minutach na jedną sesję przypada ~7 minut pracy, czyli realnie 3–10
wywołań narzędzi. Zapis z benchmarku Anthropic: proste pytanie to 1 agent,
3–10 wywołań. **Jesteśmy dokładnie w tej granicy.**

### Podział zadań

Temat dzielisz **na pytania, nie na działy tematu.** „Protokoły w obszarze X" to
dział. „Czy w 2026 używa się jeszcze protokołu Y, bo dokumentacja go wymienia" to
pytanie.

Pięć pytań, które dobrze pokrywają temat hackathonowy:

1. **Mechanizm** — jak to działa, jaka jest technologia pod spodem
2. **Stan praktyki** — co ludzie realnie robią w 2026, co jest martwe
3. **Wektor** — jak się to atakuje / jak to chronić, konkretnie
4. **Narzędzia** — czym się to robi, gotowe biblioteki, kodu, frameworki
5. **Jak to się ocenia** — co jury / organizator / kryterium będzie patrzeć

Pytania 3 i 5 są najczęściej pomijane, a to one decydują o wyniku. Jeśli musicie
obciąć — obcinajcie pytanie 2, nie 5.

Każda sesja dostaje dokładnie cztery rzeczy:

```text
CEL:        Jedno pytanie. Jedno zdanie. Nie „napisz o temacie".
ZAPISZ DO:  research/NN-nazwa.md — struktura jak niżej
ŹRÓDŁA:     Tak: dokumentacja, repo, paper/standard, changelog, CVE, blog z datą.
            Nie: listy "10 najlepszych", fora bez odpowiedzi autora.
            Fakt bez linku → [niepotwierdzone].
GRANICA:    Czego NIE szukam.  ← najważniejsze pole, najczęściej pomijane
```

Ostatnie pole chroni przed jednym konkretnym trybem awarii: przy zadaniu „zrób
research o X" trzy sesje zrobią dokładnie to samo. Zadania mają się **nie pokrywać
w zakresie**, nawet jeśli dotyczą tego samego obszaru. Zadanie „jak to działa" i
zadanie „co z tym zrobić w praktyce" to dwa różne pliki.

### Struktura pliku

```markdown
# research/03-wektor.md

## Ustalone
- Rzecz. — źródło: <link>, dostęp 2026-10-03

## Niespójne
- Źródło A mówi X, źródło B mówi Y. Nie rozstrzygnięte. Oba linki.

## Nie udało się ustalić
- Pytanie bez odpowiedzi — dlaczego (brak źródeł / sprzeczne)

## Dalej
- Czego nie szukałem, bo było poza moim zadaniem.
```

**Sekcja „Niespójne"** — sprzeczność między źródłami jest informacją. Średnia
między X a Y jest informacją **tylko zła**. Przy godzinowym researchie będzie ich
więcej, bo mniej czasu na pogłębienie. To jest nieuniknione.

**Sekcja „Nie udało się ustalić"** przy jednej godzinie to **nie wyjątek, to norma.**
To jedyna sekcja, która mówi wprost, gdzie ziemia jest miękka.

### Dwie pułapki, o których wiadomo z góry

**Śmieciowe źródła.** Agenci wybierają je, dopóki im nie zabronisz — opisane wprost
u Anthropic: *„our early agents consistently chose SEO-optimized content farms over
authoritative but less highly-ranked sources like academic PDFs"*. Linia o źródłach
w każdym zadaniu to nie formalność. Bez niej dostaniecie szybki, płynny, całkowicie
nieprawdziwy research.

**Pytania za wąskie.** *„Agents often default to overly long, specific queries that
return few results"* — krótkie i szerokie zwracają wyniki. Przy 7 minutach na sesję
nie macie czasu na drugą próbę, więc zacznijcie szeroko.

---

## Brainstorm: 3 sesje, 13 minut, 3 różne wejścia

**To jest cały trik i jest tu, bo zakład mówi, że mamy compute.**

Trzy sesje dostają **ten sam temat i ten sam research, ale każda zaczyna inaczej.**
Nie trzy warianty promptu do jednej sesji — trzy osobne sesje, osobne konteksty.

| Sesja | Wejście | Szuka |
|---|---|---|
| **A — pragmatyk** | „Jaka jest najprostsza rzecz, która robi to dobrze?" | rozwiązania, które da się zbudować i zdemo w 14 godzin |
| **B — sceptyk** | „Załóż, że poprzednia próba się udała. Dlaczego to jest złe rozwiązanie?" | rozwiązania, które przetrwają krytykę |
| **C — outsider** | „Gdybyś robił to w swojej branży, jak byś to zrobił?" | rozwiązania spoza branży, których nikt nie szuka |

**13 minut to mało.** Dlatego trzy sesje lecą **równolegle**, nie po kolei, i każda
dostaje research jako wejście. Po sesjach: **porównajcie na głos, 5 minut, wybierzcie
jedną.**

Zapisujecie w kapsule sekcję 2 — dlaczego ta, a nie pozostałe dwie, i **dlaczego
odrzuciliście pozostałe**. To jest ta część, której system 2 nie odtworzy.

Sesja C wygrywa najczęściej. Nikt w zespole nie zna tej dziedziny, więc „jak bym to
zrobił u siebie w robocie" to jedyny prompt, który nie jest skażony waszymi
assumpcjami.

---

## Kapsuła, potem STOP

Lead czyta **pliki**, nie podsumowania z sesji. Wypełnia [`KAPSULA.md`](KAPSULA.md).

**Jedyne miejsce, w którym zespół wchodzi:** 10 minut. Krótko, nie czytajcie tego
na głos w całości — to zrobiliście już przy wyborze. Powiedzcie tylko:
*„kapsuła mówi, że budujemy X, pięć kawałków wygląda tak, każdy sprawdza czy jego
jest na liście"*.

**Zespół wybiera opcję. Na głos. To jest brama i nie ma jej obejścia.**

Po wyborze system 1 **milczy do końca.** Jeśli ktoś z systemu 2 pyta — odpowiedzią
jest sekcja 4 kapsuły, a jeśli jej tam nie ma, to dopisuje tam i jeździ dalej.

---

## Reguła kciuka

> **Kapsuła, która nie mieści się na kartce A4, nie jest kapsułą.**

Research jest w `research/`, osobno. Kapsułę czyta pięć osób, w tym jedna trzeźwa.
Jeśli ma 8 stron, nie zostanie przeczytana — i wrócicie do pięciu różnych modeli
problemu, czyli dokładnie do tego trybu awarii, który cała ta konstrukcja
ma zlikwidować.
