# T3 — Uprość to, co nie broni pomysłu

Mandat: **podejrzane domyślnie**. Dla każdego: *czy to zapobiega konkretnej
pomyłce, którą widziałem, czy tylko wygląda, jakby zapobiegała?*

**Odpowiedź na to pytanie była niepokojąco często: „zapobiega, ale jest błędna".**
Większość tego, co znalazłem, to nie rzeczy do usunięcia, tylko **zdania, które
się nie zgadzają ze sobą**. Naprawa faktu mniejsza niż usunięcie reguły.

---

## Naprawione (bo były po prostu nieprawdziwe)

**README.md:9 — „cztery pliki"**
Tabela, do której linkuje, wylicza pięć. Sam link prowadził do sekcji, która
kontradyktuje. → **„pięć plików"**.

**README.md:253 — „siedem reguł z AGENTS.md §4"**
§4 ma osiem (ostatnia to *„kapsuła może być zła"*, którą `3-CHEATSHEET.md:128-129`
wymienia jako jedną z pięciu rzeczy do zapamiętania — więc nie do wyrzucenia).
→ **„osiem reguł"**.

**README.md:246 — „811 → 1 188 linii"**
Rzeczywista suma to 1197 (`wc -l`). → **1 197**.

**README.md:275 — „OMP jest runtime"**
Runtime jest heterogeniczny: każdy przynosi własnego coding agenta. Połowa
korpusu i tak daje komendy `claude`. → **„coding agent (OMP / Claude Code /
Codex) jest runtime"**. To nie jest kosmetyka — błędne zdanie o runtime sprawia,
że ktoś z Claude Code uważa, że robi coś nielegalnego.

---

## Naprawione (bo powodowały błąd o 3 w nocy)

**`2-BUILD.md:83` — wzorzec sekretu**
`git diff --cached | grep ... && { exit 1; }` pod `set -euo pipefail`. Działa
(sprawdzone), ale **przy pustym staging area** `grep` zwraca 1 i `set -e`
zachowuje się nieterminowanie — różnica, której nikt nie zgadnie.
→ `if git diff --cached | grep ...; then echo FAIL; exit 1; fi`.

**`KAPSULA.md:76` — w4 czeka na 1, a reszta korpusu mówi „1 i 2"**
`KAPSULA.md:65` (komentarz nad tabelą) i `2-BUILD.md:129` tłumaczą przykład
*w4 czeka na 1 i 2*, podczas gdy szablon mówi *czeka na 1*. Kolumna jest
czytana **maszynowo**. → **1, 2**.

**`KAPSULA.md:93` — „jedna komenda" przykład był pięcio-kawałkowym łańcuchem**
Komentarz nad nim mówi *JEDNA KOMENDA NA KAWAŁEK*. Agent o 1:00 nie znajdzie
siebie w `&&`. → pięć osobnych komend z `cd` do worktree.

**`KAPSULA.md:110` — `./<swoj>/check.sh`**
Worktree root to `~/w3-modele`, więc `./w3/check.sh` to katalog, którego nie ma.
→ **`./check.sh`**.

**`2-BUILD.md:22, 27, 66, 68` — to samo}
`cd ~/w3-modele` + `./w3/check.sh` + `cd "$(dirname "$0")/.."` = trzy różnych
katalogów. → worktree root, `./check.sh`, `cd "$(dirname "$0")"`.

---

## Odwiedzone i ZOSTAWIONE (z racjonowaniem)

**`AGENTS.md §4` — reguły 1–8. Nie ruszone.**
To jest system operacyjny. Każda zapobiega konkretnej pomyłce: 1 (katalog) —
kolizji, 2 (test) — kodowi bez weryfikacji, 3 (IMPORTANT) — jest jedyną, która
trzyma pętlę, 4 (merge) — deadlockom i cichym konfliktom interfejsu, 5 (review)
— uprzedzeniom autora, 6 (push) — utracie 12 godzin, 7 (sieć) — wykonaniu
instrukcji ze strony, 8 (zła kapsuła) — jedyny głos, który system nie wyda.
**Usuwasz jedną, tracisz noc.**

**Maszynowa kolejność mergów. Nie ruszona.**
Bez niej pętla stoi w nocy i pyta człowieka. Wprost wymieniona w mandacie jako
nienaruszalna.

**Reguła o interfejsach (`2-BUILD.md:154-160`). Nie ruszona.**
Bez niej maszyna rozwiąże konflikt zmieniający kontrakt — **po cichu**.

**`check.sh`. Nie ruszony.**
Bez niego nie ma pętli. Dodatkowo bramka fazy (D01) była **brakującym
elementem**, nie regułą: to, że reguła *„test zanim kod"* jest niewykonalna
dosłownie, nie znaczy, że jest zła — znaczy, że brakowało jej działania.

**`AGENTS.md` (cały plik). Nie ruszony.**
Agent nie wie, w jakiej jest sytuacji. Poza tym HANDOFF §5 zabrania zmian §4
bez powodu z T3 — powody z T3 dotyczyły **błędów w README**, nie w §4.

**`3-CHEATSHEET.md` — piątkowe `gh api` + `jq`. Zostawione.**
`gh` i `jq` to dwie zależności, których nie ma, a `git ls-remote HEAD` sprawdza
czytelność, nie prawo zapisu. To realna dziura (D08). **Ale `3-CHEATSHEET.md` jest
zegarem dla człowieka** i HANDOFF §5 mówi: nie dodawaj zależności, nie ruszaj
bez powodu z T3. Naprawa tego wymagałaby edycji zegara — a on ma być drukowany
i nie powinien się zmieniać w piątek wieczorem. **Zamiast tego: alternatywa
`git push --dry-run` jest w `DEVPLAN.md` P2 i `seed/VERIFY.md` — tam, gdzie
ludzie ją uruchomią.**

**`1-RESEARCH.md` — zakaz SEO content farms i „pytania za wąskie". Zostawione.**
To są dwa konkretne tryby awarii, które Anthropic zaobserwował u siebie
(*„our early agents consistently chose SEO-optimized content farms"*), nie
hipotetyczne. Przy 7 minutach na sesję nie ma czasu na drugą próbę.

**`README.md:208-211` — reguła o wyróżnianiu jednej linii `IMPORTANT:`. Zostawiona.**
Zapobiega konkretnej pomyłce: wyróżnienie wszystkich linii powoduje, że agent
ignoruje wszystkie. To fakt z dokumentacji Claude Code, nie pomysł.

**`README.md` sekcja „Opcjonalne — i pierwsze do odcięcia". Zostawiona.**
Mówi zespołowi, co ciąć pod presją czasu. Bez niej obetną to, czego nie wolno
(mechniczny merge), bo nie wiedzą, że jest pierwsze do uratowania.

---

## Czego NIE zrobiłem (i dlaczego)

- **Nie dodałem żadnej nowej reguły.** Projekt przeszedł trzy rundy upraszczania
  (3391 → 1246 → 1188). Każda nowa reguła jest podejrzana domyślnie, a ja nie
  znalazłem pomyłki, której bym nie mógł naprawić poprawieniem istniejącego
  zdania.
- **Nie usuwałem niczego, co zapobiega konkretnej pomyłce.** Mandat wyraźnie
  mówił, czego nie ruszać. Nic z tej listy nie zostało dotknięte.
- **Nie edytowałem `AGENTS.md §4`.** Wszystkie cztery fakty, które naprawiłem,
  były w `README.md` — jedyny wyjątek to `2-BUILD.md` (wzorzec `check.sh` i
  ścieżki), gdzie naprawa była mechaniczna i nie zmienia reguł.
- **Nie naprawiłem `3-CHEATSHEET.md:13-16`** (D08). Patrz wyżej — zagadka między
  mandatem a dziurą, rozwiązana przez DUCHANIE dziury do `DEVPLAN.md`/`VERIFY.md`
  zamiast edycji zegara.
