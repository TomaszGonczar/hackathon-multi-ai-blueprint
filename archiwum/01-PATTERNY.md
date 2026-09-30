# 01 — Wzorce: co warto skopić, zanim zaczniecie wymyślać

12 rzeczy, które ktoś już sprawdził w produkcji. Każda ma źródło. Wszystkie dotyczą
pracy z agentami — bo to jedyna warstwa tego projektu, która naprawdę ma się zmienić
i o której nie warto myśleć samemu.

Nie ma tu nic o zarządzaniu zespołem. Jest tylko: **jak rozdzielić pracę między
5 ludzi i ich agentów, żeby nie zrobić z tego tłoku.**

---

## A. Research

### A1. Wiele agentów wygrywa w researchie. W kodzie — nie.

> *„Our internal evaluations show that multi-agent research systems excel especially for
> **breadth-first** queries that involve pursuing multiple independent directions
> simultaneously… We found that a multi-agent system with Claude Opus 4 as the lead agent
> and Claude Sonnet 4 subagents outperformed single-agent Claude Opus 4 by **90.2%** on our
> internal research eval."*

> *„…**most coding tasks involve fewer truly parallelizable tasks than research**, and LLM
> agents are not yet great at coordinating and delegating to other agents in real time."*

— [How we built our multi-agent research system](https://www.anthropic.com/engineering/multi-agent-research-system)

**Co to znaczy w sobotę:** okładka. Fazę nieznanej dziedziny rozdzielamy na 3–5
niezależnych podpytań i puszczamy równolegle — to jest najlepiej potwierdzona rzecz
w całym materiale. Potem **przestajemy mnożyć agentów** i jedziemy pięć osób × jeden
agent na osobę. Oszczędność jest tu nie tylko dlatego, że research się nie zrównolegla
dobrze — koszt jest mierzalny, patrz A4.

### A2. Zadanie dla podagenta ma cztery pola. Nie dziesięć.

> *„Each subagent needs an **objective**, an **output format**, **guidance on the tools and
> sources** to use, and **clear task boundaries**. Without detailed task descriptions,
> agents duplicate work, leave gaps, or fail to find necessary information."*

— [tamże](https://www.anthropic.com/engineering/multi-agent-research-system)

Konkretny tryb awarii, który cytują: przy zadaniu *„research the semiconductor shortage"*
jeden podagent poszedł w kryzys 2021, a dwóch innych **robiło dokładnie to samo** po
stronach łańcucha dostaw 2025. Podział pracy musi być w treści zadania, nie w głowie
agenta nadrzędnego.

**To zastępuje dziesięciopolowy „Mission Package"** z poprzedniej wersji. Cztery pola:
co, w jakim formacie, z jakich źródeł, gdzie kończy się jego terytorium.

### A3. Wynik podagenta ląduje w pliku, nie wraca przez agenta nadrzędnego

> *„**Subagent output to a filesystem** to minimize the 'game of telephone.' Direct
> subagent outputs can bypass the main coordinator… Subagents call tools to store their
> work in external systems, then pass lightweight references back to the coordinator.
> This prevents information loss during multi-stage processing and reduces token overhead."*

— [tamże](https://www.anthropic.com/engineering/multi-agent-research-system)

**Co to znaczy:** `research/01-analiza-traffic.md`, `research/02-techniki.md`… zamiast
12 000 tokenów wklejanych przez agenta nadrzędnego do jednego okna. Zespoł czyta pliki,
nie podsumowanie. Podsumowanie bywa wygodniejsze i zawsze jest gorsze.

### A4. Koszt się nie zgadza z intuicją

> *„In our data, agents typically use about **4×** more tokens than chat interactions, and
> multi-agent systems use about **15×** more tokens than chats. For economic viability,
> multi-agent systems require tasks where the value of the task is high enough to pay for
> the increased performance."*

— [tamże](https://www.anthropic.com/engineering/multi-agent-research-system)

**Pytanie na wieczór:** czy zespół ma tokeny na to 15×? Jeśli tak — research można
pchać szeroko. Jeśli nie — wąskie i krótkie. **To jest realna zmienna decyzyjna, nie
detalistyka.** Patrz D1.

### A5. Skalowanie wysiłku ma zapisane liczby

> *„Simple fact-finding requires just **1 agent with 3–10 tool calls**, direct comparisons
> might need **2–4 subagents with 10–15 calls each**, and complex research might use
> **more than 10 subagents** with clearly divided responsibilities."*

— [tamże](https://www.anthropic.com/engineering/multi-agent-research-system)

> *„We counteracted this tendency by prompting agents to **start with short, broad
> queries**, evaluate what's available, then progressively narrow focus."*

— [tamże](https://www.anthropic.com/engineering/multi-agent-research-system)

**Co to znaczy:** nie „zrób research". Zapisane w [`03-SYSTEM-RESEARCH.md`](03-SYSTEM-RESEARCH.md)
konkretne liczby. Decyzja D1 to wybór z tej tabelki, nie improwizacja.

### A6. Agenci wybierają śmieciowe źródła, dopóki im nie zabronisz

> *„Human testers noticed that our early agents consistently **chose SEO-optimized
> content farms** over authoritative but less highly-ranked sources like academic PDFs or
> personal blogs. Adding source quality heuristics to our prompts helped resolve this
> issue."*

— [tamże](https://www.anthropic.com/engineering/multi-agent-research-system)

**Co to znaczy:** w briefie ma być **jedna linia o źródłach** — wolno: dokumentacja,
repo, paper, changelog, standards. Nie wolno: blog bez daty, „10 najlepszych X",
fora bez odpowiedzi autora. Reszta to prawdopodobnie prawda i nie ma jak tego sprawdzić.

---

## B. Produkcja

### B1. Test zamyka pętlę. Bez niego jesteś ty.

> *„Claude stops when the work looks done. Without a check it can run, 'looks done' is the
> only signal available, and **you become the verification loop: every mistake waits for
> you to notice.**"*

> *„**The trust-then-verify gap.** Claude produces a plausible-looking implementation
> that doesn't handle edge cases. **Fix:** Always provide verification. If you can't verify
> it, don't ship it."*

— [Claude Code — Best practices](https://code.claude.com/docs/en/best-practices)

**To jest najważniejszy wzorzec w całym materiale.** Nie „dobre praktyki". Mechanizm:
agent czyta wynik testu, poprawia, czyta znowu. Bez tego zatrzymuje się na „wygląda
gotowe" i każdy błąd czeka, aż ktoś zauważy. **Decyzja D3.**

### B2. Spec ma cztery części. Nie jedenaście pól.

> *„The most useful specs are **self-contained**: they **name the files and interfaces
> involved**, **state what is out of scope**, and **end with an end-to-end verification
> step** that proves the feature works. Time spent making the spec precise pays off more
> than time spent watching the implementation."*

— [Claude Code — Best practices](https://code.claude.com/docs/en/best-practices)

> *„…start with a minimal prompt and ask Claude to **interview you** using the
> `AskUserQuestion` tool… then **write a complete spec to SPEC.md**. Once the spec is
> complete, **start a fresh session to execute it.** The new session has clean context
> focused entirely on implementation, and you have a written spec to reference."*

— [tamże](https://code.claude.com/docs/en/best-practices)

**Cztery części:** *co* · *gdzie* (pliki, interfejsy) · *czego nie robimy* · *jak sprawdzamy*.
Spec pisze agent, pytając człowieka. Sesja, która go wykonuje, jest **nowa** — nie ta,
która pisała. Poprzednia wersja miała 10 pól Mission Package; cztery wystarczają, a
cztery da się utrzymać.

### B3. Worktree na osobę — kolizje są strukturalnie niemożliwe

> *„Run multiple Claude sessions in parallel… **Worktrees: run separate CLI sessions in
> isolated git checkouts so edits don't collide.**"*

— [Claude Code — Parallel sessions](https://code.claude.com/docs/en/best-practices)

Poprzednia wersja **zaprojektowała tę regułę od zera** i nazwała ją najważniejszą
(`AUDYT.md` §2 pkt 4). Narzędzie ma ją wbudowaną. Reguła nie jest potrzebna — wystarczy
nie kopiować repo ręcznie.

### B4. Świeży kontekst = uczciwy recenzent. To zastępuje obserwatora.

> *„A fresh context improves code review since Claude won't be biased toward code it just
> wrote."*

> *„**A reviewer running in a fresh subagent context sees only the diff and the criteria
> you give it, not the reasoning that produced the change**, so it evaluates the result on
> its own terms."*

— [Claude Code — Adversarial review step](https://code.claude.com/docs/en/best-practices)

Zastrzeżenie, które trzeba znać:

> *„A reviewer prompted to find gaps will **usually report some, even when the work is
> sound**, because that is what it was asked to do. **Chasing every finding leads to
> over-engineering.** Tell the reviewer to flag only gaps that affect correctness or the
> stated requirements, and treat the rest as optional."*

— [tamże](https://code.claude.com/docs/en/best-practices)

**To jest cały zamiennik obserwatora** i jest opisany w README. Trzy problemy starego
procesu (ocenia sam siebie, nie widzi źle zrozumianego tematu, szum vs cisza) znikają,
bo recenzent nie zna planu, działa wtedy kiedy trzeba, i kosztuje dwie minuty.

### B5. Buduj od początku przeciwko — dwa niezależne głosy

> *„**Voting:** Reviewing a piece of code for vulnerabilities, where **several different
> prompts review and flag the code if they find a problem**."*

> *„**Evaluator-optimizer:** one LLM call generates a response while another provides
> evaluation and feedback in a loop… the two signs of good fit: the LLM responses can be
> demonstrably improved when a human articulates their feedback; and the model can provide
> this feedback."*

— [Building effective agents](https://www.anthropic.com/research/building-effective-agents)

**Dlaczego to ważne akurat tutaj:** to jest projekt security. Kto przepuścił twoją rzecz
w środku nocy, nie Ty — bo nie miał czasu przeczytać diffu. Dwa niezależne przeglądy
pod rząd kosztują dwa razy tyle co jeden, a łapią to, czego nie łapie jeden.

### B6. Routing: tani model na łatwe, drogi na trudne

> *„**Routing** easy/common questions to smaller, cost-efficient models while hard/unusual
> questions to more capable models to optimize for best performance."*

— [Building effective agents](https://www.anthropic.com/research/building-effective-agents)

**Co to znaczy:** ten sam schemat co w ludzkim zespole. Jeden człowiek jest dobry
w „zrobić klasę, która parsuje nagłówek", inny jest dobry w „zaprojektować protokół
uwierzytelniania". Nie każdy agent w zespole musi dostać najlepszy model.

---

## C. Narzędzia, które zastępują dokumentację

### C1. Hook jest deterministyczny. Prompt jest radą.

> *„**Unlike CLAUDE.md instructions which are advisory, hooks are deterministic and
> guarantee the action happens.**"*

— [Claude Code — Hooks](https://code.claude.com/docs/en/hooks-guide)

To jest odpowiedź na zasadę „instruction is not enforcement", którą poprzednia wersja
pisała cztery razy i nie domknęła. Odpowiedź jest w narzędziu. **Decyzja D5.**

### C2. `/doctor prompt-audit` szuka sprzeczności sam

> „…looks for problems such as **instructions written for older models, references to
> files or commands that don't exist, and instructions that contradict each other**."

— [Claude Code — Memory](https://code.claude.com/docs/en/memory)

Poprzedni pakiet zbudował własny census w 776 liniach, żeby szukać rozjazdu między
plikami. Ten census porównywał identyfikatory, nie treść zdań — dlatego przepuścił
żywą sprzeczność opisaną w `AUDYT.md` §3.1. Ta komenda robi dokładnie to, o co
chodziło.

### C3. Nazwa katalogu to sygnał dla agenta

> *„Folder hierarchies, naming conventions, and timestamps all provide important signals
> that help both humans and agents understand when and how to utilize information."*

— [Effective context engineering](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)

> *„find the **smallest possible set of high-signal tokens** that maximize the likelihood of
> some desired outcome."*

— [tamże](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)

**Co to znaczy:** nazwanie katalogów i branchy tak, żeby *z nazwy* było widać, co jest
w środku, to jest inżynieria kontekstu, nie estetyka. `w2-detekcja-anomalii/` mówi
więcej niż `module_b/`. Działa na obu stronach — człowiek i agent.

### C4. Przykłady biją reguły

> *„Teams will often stuff a **laundry list of edge cases** into a prompt in an attempt to
> articulate every possible rule… Instead, we recommend working to curate a set of
> **diverse, canonical examples**… For an LLM, examples are the **'pictures' worth a
> thousand words**."*

— [Effective context engineering](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)

**To jest bezpośrednia odpowiedź na pytanie „jak powinny wyglądać takie blueprinty".**
Nie: 40 reguł. Tak: **trzy zrobione przykłady i jedna zasada**. Poprzednia wersja miała
40 reguł i zero przykładów. Dlatego jest nieczytelna.

### C5. Cały proces jest już produktem: spec-kit

> *„**Constitution once per project; specify → plan → tasks → implement → converge per
> feature.**"*
> — [GitHub spec-kit](https://github.com/github/spec-kit)

Plus osobny proces do oceny pomysłu, zanim napiszesz linijkę:
> *„**intake → research → define → shape → decide**… ending in a **go / needs-clarification /
> kill** decision… stopping with a documented reason is also a useful result."*

— [tamże](https://github.com/github/spec-kit)

**Co to znaczy:** nie trzeba wymyślać faz. Istnieją gotowe, przetestowane na
tysiącach projektów, i można je zaadaptować. Ale **nie trzeba ich instalować** —
w [`04-SYSTEM-PRODUKCJA.md`](04-SYSTEM-PRODUKCJA.md) jest ich skrót w czterech krokach.
Jeśli ktoś w zespole zna spec-kit, użyj go. Jeśli nie — niech nie traci na to nocy.

---

## Czego w tych źródłach **nie ma**

Żeby nie sugerować, że wszystko jest rozwiązane:

- **Nie ma danych o 5 osobach pracujących równolegle nad jednym nowym systemem w nocy.**
  Wszystko powyżej pochodzi z pracy jednej firmy z własnymi agentami i pojedynczych
  użytkowników. Przenoszenie na wasz scenariusz to **próba, nie wniosek.**
- **Nie ma danych o degradacji jakości pod presją czasu i zmęczeniem.** Wszystkie
  benchmarki, które cytuję, mierzą agenta przy pełnym kontekście i bez presji.
  To jest luka, której żadne źródło nie wypełnia.
- **Nie ma porównania „1 człowiek + 1 agent" vs „5 ludzi + 5 agentów" vs „1 człowiek +
  10 agentów".** Nikt tego nie zmierzył w warunkach, które was dotyczą.

Są to puste miejsca, nie argumenty przeciw. Ale warto wiedzieć, że to puste miejsca.
