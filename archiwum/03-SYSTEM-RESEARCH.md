# 03 — System badawczy

**Cel:** zamienić nieznany temat w jeden plik, na którym pięć osób pracuje przez
następne 20 godzin. W 90 minut. Bez pytania nikogo o zgodę.

**Zakres:** godzina 0 → 1.5. Potem ludzie pracują równolegle, a ten system jest
gotowy. Nie wraca do researchu, chyba że pojawi się pytanie, na które brief nie
odpowiada — wtedy wraca na 10 minut.

---

## Jedno zdanie, które definiuje fazę

> **Research nie odpowiada na pytanie „jak to zrobić". Odpowiada na pytanie „co właściwie
> zostało zadane i czego jeszcze nie wiemy".**

Różnica jest praktyczna: agent, który próbuje zaproponować rozwiązanie, produkuje
prozę, która wygląda jak wiedza. Agent, który produkuje **strukturę problemu**,
produkuje coś, co da się zweryfikować i do czego można się odwołać.

---

## Podział pracy: jeden lead, 3–5 podagentów

```
              temat (surowa treść, dosłownie)
                        │
                        ▼
              ┌───────────────────┐
              │  LEAD             │  rozkłada temat na 3–5 podpytań
              │  (~5 min)         │  które da się badać NIEZALEŻNIE
              └─────────┬─────────┘
                        │  po jednym zadaniu na podagenta
        ┌───────────┬───┴───────┬───────────┐
        ▼           ▼           ▼           ▼
    ┌────────┐  ┌────────┐  ┌────────┐  ┌────────┐
    │pod-1   │  │pod-2   │  │pod-3   │  │pod-4   │   każdy: własny kontekst,
    │zapisuje│  │zapisuje│  │zapisuje│  │zapisuje│   własne narzędzia,
    │do PLIKU│  │do PLIKU│  │do PLIKU│  │do PLIKU│   zero kontaktu między sobą
    └────┬───┘  └────┬───┘  └────┬───┘  └────┬───┘
         │           │           │           │
         └───────────┴─────┬─────┴───────────┘
                           ▼
                 ┌───────────────────┐
                 │  SYNTEZA (lead)   │  czyta PLIKI, nie podsumowania
                 │  (~10 min)        │  składa BRIEF v1
                 └───────────────────┘
```

**Dlaczego podagenty nie widzą siebie:** dwa niezależne dochodzenia do tego samego
faktu dają niezależne potwierdzenie. Jedno drugie zgadza w 100% znaczy coś zupełnie
innego niż dwa niezależne potwierdzenia tego samego faktu.

To jest starsze niż agenci — to jest powód, dla którego w ogóle mamy dwie
niezależne gałęzie dowodu. Agent nie jest tu wyjątkiem, jest tylko szybszy.

---

## Cztery pola zadania

Każdy podagent dostaje **dokładnie** te cztery rzeczy. Nie więcej. (Wzorzec A2.)

```text
CEL:        Jedno zdanie. Co mam ustalić — nie "napisz o temacie", tylko konkretne pytanie.
FORMAT:     Gdzie zapisuję (research/NN-nazwa.md) i w jakiej strukturze (nagłówek + źródła).
ŹRÓDŁA:     Dozwolone: dokumentacja, repo, paper/standard, changelog, CVE, oficjalne blogi.
            Niedozwolone: blogi bez daty, listy "10 najlepszych", fora bez odpowiedzi autora.
            Każdy fakt: link + data dostępu. Bez linku → oznacz [niepotwierdzone].
GRANICA:    Czego NIE szukam. To pole jest najważniejsze i najczęściej pomijane.
```

Ostatnie pole jest najważniejsze. Bez niego podagenty robią dokładnie to samo — to
udokumentowany tryb awarii: przy zadaniu *„research the semiconductor shortage"*
jeden poszedł w kryzys 2021, a dwóch innych zrobiło to samo o łańcuchu dostaw 2025.

**Przykład dwóch realnych zadań na ten sam temat:**

```text
CEL:     Jakie protokoły i formaty są realnie używane w [obszar], a które są martwe.
GRANICA: NIE szukam historii protokołów. Interesuje mnie tylko stan na 2026.

CEL:     Jakie są typowe wektory ataku na [klasa systemów] i jak się przed nimi bronić.
GRANICA: NIE szukam ogólnych rad "best practices". Konkretne CVE, konfiguracje, checklisty.
```

Te dwa pytania dają inne pliki, innych ludzi do przeczytania i **brak pokrywających się
fragmentów**. Dokładnie o to chodzi.

---

## Struktura pliku wynikowego

Każdy podagent pisze do swojego pliku, **nie wysyła wyniku do leada** (wzorzec A3 —
„game of telephone" zjada informację i tokeny).

```markdown
# research/02-protokoly.md

## Ustalone
- Rzecz, którą wiemy. — źródło: URL, dostęp 2026-10-03

## Niespójne
- Źródło A mówi X, źródło B mówi Y. **Nie rozstrzygnięte.** Oba linki.

## Nie udało się ustalić
- Pytanie, na które nie znaleziono odpowiedzi. — dlaczego (brak źródeł? sprzeczne?)

## Sugestie na dalsze pytania
- Czego nie szukałem, bo to było poza moim zadaniem.
```

Sekcja **Niespójne** jest najważniejsza i najczęściej pomijana. Sprzeczność między
źródłami to informacja, nie problem do rozstrzygnięcia głosowaniem. Jeśli zespół
straci 20 minut na rozstrzyganie, wygrał — bo wie, gdzie ziemia jest miękka.

Sekcja **Nie udało się ustalić** chroni przed tym, czego najbardziej się boicie:
budowania na fundamencie, którego nikt nie sprawdził.

---

## Skalowanie: konkretne liczby, nie „zrób research"

Cytat ([wzorzec A5](01-PATTERNY.md)):

> *„Simple fact-finding requires just **1 agent with 3–10 tool calls**, direct comparisons
> might need **2–4 subagents with 10–15 calls each**, and complex research might use
> **more than 10 subagents** with clearly divided responsibilities."*

Przekład na sobotę:

| Typ podpytania | Ile podagentów | Komendy na agenta | Kto czyta wynik |
|---|---|---|---|
| „jak to działa" (protokół, format) | 1 | 3–10 | 1 osoba + lead |
| „który wybrać" (2–3 opcje) | 2–4 | 10–15 | decyzja zespołowa, 10 min |
| „jak to zrobić dobrze" (wzorce, best practice) | 3–5 | 10–15 | wszyscy, w syntezie |

**Nie przekraczajcie 5.** Powyżej tego lead nie jest w stanie zsyntetyzować wyników
i zamiast syntezy dostaniecie drugi zestaw plików do przeczytania.

---

## Synteza → BRIEF v1

Lead czyta **pliki**, nie podsumowania. Składa **jedną stronę**. Struktura:

```markdown
# BRIEF v1 — zatwierdzony 2026-10-03, godz. 1:30

## 1. Co robimy
Jedno zdanie. Da się je obalić — jeśli nie, wracamy do researchu.

## 2. Co wiemy
5–8 punktów, każdy z linkiem. To jest rdzeń. Reszta zespołu tego nie rozszerza.

## 3. Czego nie wiemy
Lista otwartych pytań. Uczciwa. Ktoś na pewno zacznie na to patrzeć.

## 4. Jak wygląda "gotowe"
Testy, które muszą przejść. Najlepiej zanim ktoś zacznie pisać.

## 5. Kto robi co
Pięć workstreamów, pięć osób, jeden wiersz na każdy: kto, co, gdzie, czym sprawdzamy.
```

**Reguła twarda: jeśli brief nie mieści się na jednej stronie, to nie jest brief.**
Brief na 8 stron nie zostanie przeczytany w 20:00. Skróć do rozmiaru, który zmieści się
na kartce A4 — reszta jest w plikach `research/`, do których nikt nie zajrzy, i o to
chodzi.

**Kto to pisze:** lead, w 10 minut, na podstawie plików. **Kto to czyta:** wszyscy,
na głos, w 15 minut. **Kto to zatwierdza:** jeden człowiek, na głos. Reszta nie głosuje,
tylko zadaje pytania w tych 15 minutach.

---

## Trzy pułapki, o których wiadomo zanim ktokolwiek w nie wpadnie

### 1. Agenci wybierają śmieciowe źródła, dopóki im nie zabronisz

> *„…our early agents consistently **chose SEO-optimized content farms** over
> authoritative but less highly-ranked sources like academic PDFs or personal blogs."*
> — [Anthropic](https://www.anthropic.com/engineering/multi-agent-research-system)

Linia o źródłach w każdym zadaniu (pole 3 wyżej) to nie formalność. Bez niej dostaniecie
szybki, płynny, zupełnie nieprawdziwy brief.

### 2. Zbyt wąskie pytania zwracają zero wyników

> *„Agents often default to overly long, specific queries that return few results…
> **start with short, broad queries**, evaluate what's available, then progressively
> narrow focus."*
> — [tamże](https://www.anthropic.com/engineering/multi-agent-research-system)

Krótkie i szerokie najpierw, potem zawężanie. Odwrotna kolejność to najczęstszy
powód pustego researchu.

### 3. Zgodność agentów nie jest prawdą

Dwa podagenty, które znalazły to samo i napisały to samo, **nie są dwoma dowodami**.
Mogą czytać to samo źródło. Zgodność jest własnością źródeł, nie świata.

Praktyczna konsekwencja: **w briefie znajdzie się tylko to, co ma link.** Reszta jest
oznaczona jako niepotwierdzona i budowanie na niej jest dopuszczone, ale zapisane.
Poprzednia wersja miała tę zasadę i dobrze — zostaje.

---

## Czego ten system **nie** robi

- **Nie produkuje rozwiązania.** Jeśli brief zawiera propozycję architektury, to
  znak, że agent poszedł za daleko. Wróć do struktury problemu.
- **Nie wraca w nocy.** Jest wyjątek: pytanie, na które brief nie odpowiada, a które
  blokuje pracę. Wtedy 10 minut, jeden podagent, dopisek do briefu **z numerem**.
- **Nie zastępuje wiedzy człowieka o temacie.** Nikt z was nie zna dziedziny. Brief
  daje wam strukturę, w której możecie szukać — nie odpowiedzi.
- **Nie gwarantuje, że temat jest zrozumiany dobrze.** Nikt tego nie gwarantuje. Jeśli
  brief jest zły, zobaczycie to przy budowaniu, w godzinie 4. To jest nieuniknione i
  żadne narzędzie tego nie usuwa.
