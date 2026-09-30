# 02 — Sześć decyzji do podjęcia

Każda karta: **pytanie → dlaczego to ważne → opcje z kosztem → co by rozstrzygnęło →
co się dzieje, jeśli nie zdecydujecie.**

Opcje są podane z liczbami, nie z estetyką. Każda ma cenę — żadna nie jest darmowa.
Ostatnia kolumna to **default**, żeby wieczór nie utknął na analizie: jeśli nie
zdecydujecie, robicie default i jedziecie dalej. Decyzja, którą podjęliście z
niepisanego, jest gorsza od napisanej, ale lepsza od braku.

Legenda statusu: `OTWARTE` · `DOMYŚLNE` · `ZAMKNIĘTE`

---

## D1 — Ile researchu, zanim padnie pierwsza linia kodu?

**Status:** `OTWARTE` · **Default:** 90 minut, szeroko, 3–5 podagentów równolegle

### Dlaczego to ważne

To jedyne miejsce w całym projekcie, gdzie wiele agentów naprawdę wygrywa — plus 90.2%
na wewnętrznym eval-u Anthropic (wzorzec A1). Ale research kosztuje **~15×** tyle
tokenów co zwykły chat (A4). Więc to nie jest pytanie „czy warto”, tylko „czy was stać".

| Opcja | Koszt | Ryzyko |
|---|---|---|
| **A. Dużo (60–120 min)** | 15× tokeny, blokuje ~2 osoby | Temat źle zrozumiany → 6 h budowania niczego |
| **B. Mało (20 min), zacząć build równolegle** | tanio | Równoległy build na domysłach, potem przebudowa |
| **C. tylko jaśnie punkty, reszta w trakcie** | najtaniej | fragmentaryczny kontekst, dużo sporów |

### Co by rozstrzygnęło

Czy zespół ma dostęp do tokenów w nieograniczonym albo dużym limicie. To pytanie do
osób, które o tym decydują — nie do dokumentów.

### Jeśli nie zdecydujecie

**A, z twardym stopem o 90 minut.** Nie dlatego, że jest najlepsza, tylko dlatego, że
najlepiej się broni: research jest jedyną fazą, którą da się skrócić później. Błędnie
zrozumiany temat nie.

> **Uwaga o tym, czego ta decyzja NIE rozstrzyga:** rozjazd między planem a rzeczywistością.
> Żaden mechanizm tego nie wykryje — patrz D2 i sekcja o tym, czego nie da się
> zautomatyzować w [`04-SYSTEM-PRODUKCJA.md`](04-SYSTEM-PRODUKCJA.md).

---

## D2 — Jeden spec na wszystko, czy spec per workstream?

**Status:** `OTWARTE` · **Default:** spec per workstream, 4 części, agent pisze pytając człowieka

### Dlaczego to ważne

To decyzja o koszcie kontekstu, nie o estetyce. Każdy agent startuje z czystym oknem.
Jeśli dacie mu 200 linii speca całego projektu, przeczyta je i zignoruje połowę
(C1 → wzorzec „attention budget"). Jeśli dacie mu 20 linii jego własnego — przeczyta wszystko.

| Opcja | Koszt | Ryzyko |
|---|---|---|
| **A. Jeden SPEC.md na wszystko** | taniej napisać | agent gubi się, `04` na `main` 5-krotnie |
| **B. Spec per workstream (rekomendowane)** | ×5 pisania, ~15 min łącznie | interfejsy między specami trzeba ustalić ręcznie |
| **C. Brak specu, prompt ad hoc** | 0 | agent zgaduje interfejsy, konflikt integracyjny dopiero na merge |

### Co by rozstrzygnęło

Czy wiecie z góry, gdzie przebiegają granice między waszymi workstreamami. Jeśli tak —
B. Jeśli nie — **to jest pierwsze zadanie na wieczór, nie w sobotę.**

### Jeśli nie zdecydujecie

**B.** Cztery sekcje, nie jedenaście pól:

1. **Co** — jedno zdanie, da się obalić
2. **Gdzie** — jakie pliki/katalogi, jakich nie ruszać
3. **Czego nie robimy** — to najczęściej pomijane, a najbardziej ratuje czas
4. **Jak sprawdzamy** — jedna komenda, zwraca 0 albo 1

Pisze je agent, pytając was przez `AskUserQuestion`, i **zapisuje do `SPEC.md`**.
Sesja, która potem implementuje, jest **nowa** — nie ta, która pisała.
Źródło: [B2](01-PATTERNY.md).

---

## D3 — Co jest „tym testem"?

**Status:** `OTWARTE` · **Default:** jeden skrypt na workstream, `bash workstream-X/check.sh` → exit 0/1

### Dlaczego to ważne

**To jest jedyna decyzja, bez której reszta nie działa.**

Mechanizm, bez którego system produkcyjny nie istnieje:

> *„Claude stops when the work looks done. Without a check it can run, 'looks done' is the
> only signal available, and **you become the verification loop: every mistake waits for
> you to notice.**"*
> — [Claude Code](https://code.claude.com/docs/en/best-practices)

Jeśli wyjdziesz z wieczoru z jedną rzeczą — niech to będzie ta komenda. Reszta jest
opcjonalna.

| Opcja | Koszt | Ryzyko |
|---|---|---|
| **A. Skrypt per workstream** | 10–20 min na workstream, ×5 | najwyższa siatka bezpieczeństwa |
| **B. Jeden test e2e na całość** | tanio | nie działa, dopóki nie zadziała wszystko naraz — czyli prawie nigdy w nocy |
| **C. Ręczna checklista „obejrzyj"** | 0 | dokładnie ten tryb awarii, który opisuje cytat wyżej |

### Co by rozstrzygnęło

Jak wygląda ocena. Jeśli scoring to **„działa / nie działa"** na żywo — potrzebujecie
A. Jeśli to **analiza statyczna / raport / prezentacja** — A w innej formie, ale wciąż
z komendą, bo jury i tak będzie patrzeć na wynik.

**Pułapka, którą znamy:** „zielony test, który nic nie skanuje, nie jest dowodem"
— to z poprzedniej wersji (`AUDYT.md` §2 pkt 7) i wciąż prawdziwe. Test ma **coś
złamać**. Zanim napiszecie test, zepsujcie kod na złoto i sprawdźcie, że test to zauważa.

### Jeśli nie zdecydujecie

**A, z zasadą: agent ma prawo zatrzymać się dopiero po zielonym teście.** Wpiszcie to
jako regułę w `CLAUDE.md` i jako `--allowedTools`. Jeśli test nie istnieje, workstream
nie startuje.

---

## D4 — Review: świeża sesja, wbudowane `/code-review`, czy tylko człowiek?

**Status:** `OTWARTE` · **Default:** świeża sesja, 2 minuty, diff + kryteria

### Dlaczego to ważne

To jest **zamiennik obserwatora** i jedyna decyzja, która mówi, czy wywracamy
z poprzedniej wersji coś poza samym obserwatorem.

Mechanizm, dla którego warto to zrobić:

> *„**A fresh context improves code review since Claude won't be biased toward code it just
> wrote.**"*
> *„A reviewer running in a fresh subagent context **sees only the diff and the criteria
> you give it, not the reasoning that produced the change**."*
> — [Claude Code](https://code.claude.com/docs/en/best-practices)

| Opcja | Koszt | Ryzyko |
|---|---|---|
| **A. Świeża sesja per PR** | ~2 min × liczba PR-ów | nadpłaca: recenzent zawsze coś znajdzie (patrz zastrzeżenie) |
| **B. Wbudowane `/code-review`** | 1 komenda, bez konfiguracji | nie zna twojego speca, więc nie wie co jest ważne |
| **C. C2 — dwa niezależne przeglądy pod rząd** | ×2 do A | najlepsze wykrywanie, największy szum |
| **D. Tylko człowiek** | 0 | człowiek o 4 rano nie czyta diffów |

### Co by rozstrzygnęło

Ile PR-ów realistycznie powstanie. Przy ~15 PR-ach opcja A to 30 minut łącznego
czasu — niedrobnostka. Przy 60 — zaczyna boleć i wtedy B.

**Zastrzeżenie, które trzeba powiedzieć na głos:** *„A reviewer prompted to find gaps
will usually report some, even when the work is sound… chasing every finding leads to
over-engineering."* Recenzent trzeba **poprosić, żeby zgłaszał tylko braki dotyczące
poprawności i speca**, a resztę zignorował. Inaczej budujecie abstrakcje do rzeczy,
które nie mogą się zdarzyć.

### Jeśli nie zdecydujecie

**A, z wyrównaniem B na szybko:** `claude -p "review diffu przeciw SPEC.md, zgłoś tylko
braki w poprawności, nie styl"`. Jedna linia, zero konfiguracji, działa od minuty zero.

---

## D5 — Co **musi** działać mechanicznie?

**Status:** `OTWARTE` · **Default:** 3 rzeczy, reszta to tekst

### Dlaczego to ważnie

Stara wersja wynalazła zasadę „instruction is not enforcement" i napisała ją cztery
razy, nie domykając. Odpowiedź jest prostsza niż 776 linii censusu:

> *„**Unlike CLAUDE.md instructions which are advisory, hooks are deterministic and
> guarantee the action happens.**"*
> — [Claude Code — Hooks](https://code.claude.com/docs/en/hooks-guide)

| Kandydat na obowiązek | Mechanizm | Koszt |
|---|---|---|
| Test przechodzi przed commitem | Stop hook | 5 min |
| Nikt nie pushuje na `main` | branch protection | 5 min, ale **wymaga** dostępu do repo — patrz niżej |
| Brak sekretów w repo | pre-commit skan | 15 min na konfigurację |
| Zmiany Briefu to numerowane poprawki | PR review | proceduralnie |
| Każdy push co 30 min | dyscyplina | **nie da się** — zostaje tekstem |

**Uwaga praktyczna:** jeśli nie macie prawa do repo z branch protection, opcja
„nikt nie pushuje na main" spada do dyscypliny. Wtedy uczciwie zapiszcie to jako
ograniczenie, zamiast pisać „jest zabezpieczone". Poprzednia wersja miała dokładnie ten
problem w 4 miejscach (`AUDYT.md` §3).

### Co by rozstrzygněło

Sprawdźcie **teraz**, nie w sobotę: czy każdy z pięciu ma prawo pchać na `main`. Od tego
zależy, czy merge jest bramką (dobrze) czy konwencją (słabo).

### Jeśli nie zdecydujecie

**Trzy: test w commicie, brak sekretów, main chroniony.** Wszystko inne tekst.
Jeśli czegoś nie da się zmechanizować — dopiszcie to do `AUDYT.md` jako znane
ograniczenie, nie jako regułę.

---

## D6 — Czy to w ogóle mieści się w czterech dniach?

**Status:** `OTWARTE` · **Default:** tak, z jedną fazą przygotowania

### Dlaczego to ważne

Stary plan zakładał sześć faz przygotowania rozłożonych na dwa tygodnie i mówił
„P0–P2 są niepodległe negocjacjom" (`AUDYT.md` §3.4). Dziś jest wtorek, sobota za
4 dni. **Ten plan jest nieegzekwowalny i to nie jest jego wina — to mismatch.**

| Opcja | Koszt | Ryzyko |
|---|---|---|
| **A. Jedna sesja 30 min w piątek** | 30 min | coś pokaże się dopiero w sobotę |
| **B. Zero przygotowania** | 0 | 90 min setupu na miejscu zamiast 90 min researchu |
| **C. Realizować plan poprzedniej wersji** | 2 tygodnie | w sobotę budujecie proces zamiast produktu |

### Co zrobić w tych 30 minutach

Dokładnie lista w [`05-PIESĆ-NA-SOBOTE.md`](05-PIESC-NA-SOBOTE.md), sekcja „Piątek".
Trzynaście punktów, wszystkie odwracalne.

### Jeśli nie zdecydujecie

**A.** Bo opcja B kosztuje te same 90 minut — tyle że na miejscu, w chaosie, zamiast
w spokoju piątkowego wieczoru.

---

## Podsumowanie: co zostaje do zrobienia po wieczorze

| # | Co | Kto | Kiedy |
|---|---|---|---|
| D1 | Sprawdzić limit tokenów / kredyt API | kto zarządza kontami | **piątek** |
| D2 | Narysować granice pięciu workstreamów | cały zespół, 20 min | **piątek** |
| D3 | Napisać jeden działający `check.sh` dla jednego workstreamu | 1 osoba | **piątek** |
| D4 | Wybrać komendę review | 1 osoba | **piątek** |
| D5 | Sprawdzić prawa do repo | kto ma token GitHuba | **piątek** |
| D6 | Wpisać liczby do dokumentu i wydrukować | team-lead | **piątek** |

Sześć pozycji. Nie sześćdziesiąt sześć. Poprzednia wersja miała ich 77, a to nie
liczyło jeszcze 18 stałych i 14 pytań.
