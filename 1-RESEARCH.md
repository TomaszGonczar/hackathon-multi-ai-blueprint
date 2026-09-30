# 1 — System researchu i brainstormu

**Wejście:** temat ogłoszony na kartce.
**Wyjście:** [`KAPSULA.md`](KAPSULA.md) wypełniony.
**Kto:** jeden laptop, jeden człowiek, OMP. Reszta zespołu **w tym czasie nie czeka** —
patrz [`3-PIESC.md`](3-PIESC.md).
**Stop:** zespół wybrał opcję na głos. Wtedy system 1 milczy na cały czas systemu 2.

---

## Układ: trzy przebiegi, ~2 godziny

```
  TEMAT
    │
    │  przebieg A — ~50 min
    ▼
  ┌──────────────────────────────────────────────┐
  │  RESEARCH: 6–10 sesji równolegle             │
  │  każda dostaje jedno pytanie, nie temat      │
  └──────────────────┬───────────────────────────┘
                     │  każda zapisuje do PLIKU, nie gada
                     ▼
              research/*.md   (5–10 plików)
                     │
                     │  przebieg B — ~30 min
                     ▼
  ┌──────────────────────────────────────────────┐
  │  BRAINSTORM: 3 sesje, 3 różne wejścia        │
  │  (patrz niżej — to jest cały trik)           │
  └──────────────────┬───────────────────────────┘
                     ▼
              3 propozycje rozwiązania
                     │
                     │  przebieg C — ~20 min
                     ▼
  ┌──────────────────────────────────────────────┐
  │  LEAD: czyta pliki, składa kapsułę           │
  │  → 15 min czytanie na głos → ZESPÓŁ WYBIERA   │
  └──────────────────┬───────────────────────────┘
                     ▼
                 KAPSULA.md
```

---

## Przebieg A — research: 6–10 sesji

**Dlaczego tyle:** to jedyne miejsce w całym projekcie, gdzie wiele agentów naprawdę
wygrywa. Anthropic mierzy na swoim eval-u badawczym przewagę **+90,2%** nad pojedynczym
agentem — przy pytaniach, które rozgałęziają się w wiele niezależnych kierunków.
Temat hackathonu jest dokładnie takim pytaniem.
([źródło](https://www.anthropic.com/engineering/multi-agent-research-system))

**Dlaczego nie więcej niż 10:** lead musi je wszystkie przeczytać i zsyntetyzować.
Powyżej 10 synteza się rozsypuje i zostaje wam 20 plików do przeczytania o 3:00.

### Podział zadań

Temat dzielisz **na pytania, nie na działy tematu.** „Protokoły w obszarze X" to dział.
„Czy w 2026 używa się jeszcze protokołu Y, bo dokumentacja go wymienia" to pytanie.

Każda sesja dostaje dokładnie cztery rzeczy. Nie więcej:

```text
CEL:        Jedno pytanie. Jedno zdanie. Nie „napisz o temacie".
ZAPISZ DO:  research/NN-nazwa.md — struktura jak niżej
ŹRÓDŁA:     Tak: dokumentacja, repo, paper/standard, changelog, CVE, blog z datą.
            Nie: listy "10 najlepszych", fora bez odpowiedzi autora.
            Fakt bez linku → [niepotwierdzone].
GRANICA:    Czego NIE szukam.  ← najważniejsze pole, najczęściej pomijane
```

Ostatnie pole chroni przed jednym konkretnym trybem awarii: przy zadaniu „zrób research
o X" trzy sesje zrobią dokładnie to samo. Zapytania mają się **nie pokrywać w zakresie**,
nawet jeśli dotyczą tego samego obszaru. Zadanie „jak to działa" i zadanie „co z tym
zrobić w praktyce" to dwa różne pliki.

### Struktura pliku

```markdown
# research/03-protokoly.md

## Ustalone
- Rzecz. — źródło: <link>, dostęp 2026-10-03

## Niespójne
- Źródło A mówi X, źródło B mówi Y. Nie rozstrzygnięte. Oba linki.

## Nie udało się ustalić
- Pytanie bez odpowiedzi — dlaczego (brak źródeł / sprzeczne)

## Dalej
- Czego nie szukałem, bo było poza moim zadaniem.
```

**Sekcja „Niespójne" to najcenniejsza.** Sprzeczność między źródłami jest informacją.
Średnia między X a Y jest informacją **tylko zła**. Jeśli zespół straci 10 minut na
rozstrzygnięcie, wygrali — bo wie, gdzie ziemia jest miękka.

**Sekcja „Nie udało się ustalić"** chroni przed budowaniem na fundamencie, którego
nikt nie sprawdził.

### Jedna pułapka, o której wiadomo z góry

Agenci wybierają śmieciowe źródła, dopóki im nie zabronisz — opisane wprost u
Anthropic: *„our early agents consistently chose SEO-optimized content farms over
authoritative but less highly-ranked sources like academic PDFs"*. Linia o źródłach w
każdym zadaniu to nie formalność. Bez niej dostaniecie szybki, płynny, całkowicie
nieprawdziwy research.

Drugie: **krótkie i szerokie pytania zwracają wyniki, długie i wąskie nie.**
Zacznij szeroko, zawężaj w trakcie.

---

## Przebieg B — brainstorm: 3 sesje, 3 różne wejścia

**To jest cały trik i jest tu, bo zakład mówi, że mamy compute.**

Trzy sesje dostają **ten sam temat i ten sam research, ale każda zaczyna inaczej.**
Nie trzy warianty promptu do jednej sesji — trzy osobne sesje z osobnymi kontekstami.

| Sesja | Wejście | Szuka |
|---|---|---|
| **A — pragmatyk** | „Jaka jest najprostsza rzecz, która robi to dobrze?" | rozwiązania, które da się zbudować i zdemo w 12 godzin |
| **B — sceptyk** | „Załóż, że poprzednia próba się udała. Dlaczego to jest złe rozwiązanie?" | rozwiązania, które przetrwają krytykę jury |
| **C — outsider** | „Gdybyś robił to w swojej branży, jak byś to zrobił?" | rozwiązania spoza branży, których nikt nie szuka |

Po sesji: **porównajcie na głos, 10 minut, wybierzcie jedną.** Zapisujecie w kapsule
sekcję 2 — dlaczego ta, a nie pozostałe dwie. Zapisujemy **dlaczego odrzuciliście
pozostałe**, bo to jest ta część, której system 2 nie odtworzy.

Sesja C najczęściej wygrywa. Nikt w zespole nie zna tej dziedziny, więc „jak bym to
zrobił u siebie w robocie" to jedyny prompt, który nie jest skażony waszymi
assumpcjami.

---

## Przebieg C — kapsuła, potem STOP

Lead czyta **pliki** z researchu, nie podsumowania z sesji. Wypełnia
[`KAPSULA.md`](KAPSULA.md).

**Jedyne miejsce, w którym zespół wchodzi:**
15 minut, brief czytany **na głos**, pytanie: *„gdybyśmy mieli połowę czasu, co
odcinamy?"* Odpowiedź idzie prosto do sekcji 5 i 6 kapsuły.

**Zespół wybiera opcję. Na głos. To jest brama i nie ma jej obejścia.**

Po wyborze system 1 **milczy do końca.** Jeśli ktoś z systemu 2 pyta — odpowiedzią
jest sekcja 4 kapsuły, a jeśli jej tam nie ma, to dopisuje tam i jeździ dalej.

---

## Reguła kciuka

> **Brief, który nie mieści się na kartce A4, nie jest briefem.**

Research jest w `research/`, osobno. Kapsuła jest tym, co pięć osób czyta w 20:00
przy zmęczeniu. Jeśli kapsuła ma 8 stron, to nie zostanie przeczytana — i wrócicie
do pięciu różnych modeli problemu, czyli dokładnie do tego trybu awarii, który cała
ta konstrukcja ma zlikwidować.
