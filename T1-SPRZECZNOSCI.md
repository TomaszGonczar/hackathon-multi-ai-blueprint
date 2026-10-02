# T1 — Czytaj z krytykiem

Uzgodnione z operatorem (2026-10-02): **runtime jest heterogeniczny.** Każdy członek
zespołu przynosi własnego coding agenta (OMP / Claude Code / Codex / cokolwiek),
format operowania to **sesja najpierw**. `claude` w korpusie to przykład, nie wymóg.
Ta sesja (Atria, piątek wieczór, `HANDOFF.md`) to *system 1 projektu zastosowany do
samego projektu* — wykonawca T1–T6, nie uczestnik sobotniego hackathonu.

Przeczytane: `README.md`, `AGENTS.md`, `KAPSULA.md`, `1-RESEARCH.md`,
`2-BUDOWA.md`, `3-PIESC.md` (1197 linii łącznie).

---

## Sprzeczności twarde

**S1. Kawałek 4 czeka na co — jedyny przykład w systemie się nie zgadza.**
`KAPSULA.md:76` (wiersz 4 w szablonie) mówi **Czeka na: 1**.
`KAPSULA.md:65` (komentarz nad tabelą) i `2-BUDOWA.md:129` mówią **w4 czeka na 1 i 2**.
Szablon, który zespół wypełnia w sobotę, pokazuje wartość niezgodną z przykładem,
który cała reszta dokumentów tłumaczy. To kolumna, którą maszyna czyta dosłownie.

**S2. Czym jest runtime.**
`README.md:275` i `AGENTS.md:136-137` mówią *„OMP jest runtime"*.
`2-BUDOWA.md:14` powtarza to samo, a cztery linie niżej (`2-BUDOWA.md:22`, `:27`)
daje dosłowne komendy `claude`; to samo `AGENTS.md:110` (review) i `3-PIESC.md:16`
(piątkowy smoke test). Słowo mówi jedno, komenda drugie. Po uzgodnieniu z operatorem:
forma docelowa to *„twój coding agent"* z `claude -p` jako przykładem.

**S3. „Cztery pliki" vs własna tabela.**
`README.md:9` twierdzi *„Ta ma cztery pliki"* z linkiem `#pliki`. Sekcja, do której
link prowadzi (`README.md:231-242`), wylicza **pięć** (AGENTS, KAPSULA,
1-RESEARCH, 2-BUDOWA, 3-PIESC), a `README.md:124-125` opisuje jeszcze `HANDOFF.md`.

**S4. „Siedem reguł" vs osiem reguł.**
`README.md:253` mówi *„siedem reguł z `AGENTS.md` §4"*.
`AGENTS.md` §4 ma ich **osiem** — punkty 1–8 na liniach 81, 85, 91, 95, 108, 117,
120, 125. Ósma („kapsuła może być zła") to według `3-PIESC.md:128-129` jedna z pięciu
rzeczy, które trzeba wiedzieć — więc nie jest do wyrzucenia.

**S5. Liczba linii nie pasuje do plików.**
`README.md:248` mówi *„811 → 1 188 linii"*. Rzeczywista suma sześciu plików to **1197**
(`wc -l`). Różnica 9 — prawdopodobnie liczone przed drobną edycją. Nieistotne,
ale nieprawdziwe.

---

## Nakładanie się odpowiedzialności / niejednoznaczności

**S6. Gdzie jest cwd agenta i gdzie leży `check.sh` — trzy różne odpowiedzi.**
- `AGENTS.md:82` — `cd ~/w<N>-<nazwa>`, potem `./<swoj>/check.sh` (`AGENTS.md:86`)
- `2-BUDOWA.md:21` + `:27` — `cd ~/w3-modele`, potem `./w3/check.sh`
- `KAPSULA.md:93` — `./w1/check.sh` wywołane z korzenia repo

Czyli katalogiem roboczym jest worktree, a `check.sh` leży w podkatalogu kawałka
wewnątrz worktree. Wtedy `AGENTS.md:81-83` *„w swoim katalogu, nigdy poza nim"* jest
dwuznaczne: worktree (`~/w3-modele`) czy kawałek (`~/w3-modele/w3/`)? Dla kogoś, kto
nie zna gita, to decyzja, której nie da się podjąć z dokumentu.

**S7. Czas RESEARCH: maszyna stanów nie opisuje tego, co robi 4/5 zespołu.**
`AGENTS.md:44` i `:68` (stan `RESEARCH`) — *„pytasz system 1"*, *„nie piszesz kodu
rozwiązania"*.
`1-RESEARCH.md:5-6` i `3-PIESC.md:60-61` — w tym samym oknie 0:00-0:35 pozostali
czterej **kończą pisać swoje `check.sh`**. `AGENTS.md` nie wymienia tej pracy w żadnym
stanie; jedyny, który o niej mówi, to `PRZYGOTOWANIE` (`AGENTS.md:67`), czyli piątek.

**S8. `research/` — nie jest powiedziane, w którym repo ono żyje.**
`1-RESEARCH.md:77` każe systemowi-1 pisać do `research/NN-nazwa.md`.
`AGENTS.md:167` każe agentom budującym czytać `research/*.md`.
`2-BUDOWA.md:216` na sync robi `ls research/`.
Agenci pracują w worktree na osobnych branchach — jeśli `research/` istnieje tylko
tam, gdzie commitnął go system-1 (czyli na `main`), agent w worktree go nie zobaczy,
bo jego branch od tego commita odszedł. [WNIOSEK — nie jest napisane wprost.]

**S9. „Jedna komenda na kawałek" vs przykład.**
`KAPSULA.md:88` (komentarz) — *„JEDNA KOMENDA NA KAWAŁEK"*.
`KAPSULA.md:93` (przykład) — jeden łańcuch `./w1/check.sh && ./w2/... && echo $?`,
czyli jedna komenda na **wszystko**; `AGENTS.md §4.3` używa per-kawałek
(`./<swoj>/check.sh`). Dwie różne rzeczy opisane tym samym zdaniem. Drobne, ale to
pierwsza komenda, jaką zespół wpisze.

---

## Sprawdzone i NIE sprzeczne

- `AGENTS.md:6` (*„jedyny wyjątek opisany w §2"*) — `AGENTS.md:37` faktycznie
  opisuje wyjątek (blok `STAN`). Zgodne.
- `AGENTS.md:172-173` (*„wygrywa §4"*) i `2-BUDOWA.md:9-11` mówią to samo w obie
  strony — zgodnie co do pierwszeństwa `AGENTS.md`.
- Kto edytuje `STAN`: `AGENTS.md:53-59` i `README.md:215-217` mówią to samo.
- `AGENTS.md:170` (*„3-PIESC nigdy"*) i `3-PIESC.md:3` (*„do wydrukowania"*) — zgodne.
- Liczby linii przy plikach w `README.md:233-242` (196, 114, 177, 275, 150) — zgodne
  ze stanem faktycznym.
