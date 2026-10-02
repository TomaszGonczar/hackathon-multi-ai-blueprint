# START-HERE — pierwsze 30 minut soboty

**Czas:** 08:50. Temat pada o 09:00. Nie czytaj niczego innego przed 09:00.

---

## 0. Jeśli bootstrap nie był odpalony wczoraj (5 min)

```bash
cd <blueprint-repo>
bash seed/bootstrap.sh
```

Pięć katalogów w `~/`, `AGENTS.md` i `KAPSULA.md` w roocie repo rozwiązania.
Idempotentny — drugie odpalenie nie niszczy.

Jeśli nie wiesz, gdzie jest blueprint: sklonuj
`https://github.com/TomaszGonczar/hackathon-multi-ai-blueprint` (domyślny branch,
bez żadnych przełączeń) i odpal `bash seed/bootstrap.sh`.

## 1. Twój katalog (2 min)

```bash
cd ~/w1-kawalek    # zamień na swój numer
ls
cat check.sh
```

**Twój katalog to twój worktree. `check.sh` leży w jego roocie.**
Nie ma podkatalogu `w1/` — to jest cały katalog.

## 2. Zanim temat padnie (10 min)

Wypełnij **fazę 0** swojego `check.sh`:

```bash
$EDITOR ~/w1-kawalek/check.sh
```

- zmień `PHASE=0` na `PHASE=1`
- wypełnij sekcje 1–3 (budowanie, testy, czy test coś łapie)
- `bash ~/w1-kawalek/check.sh` musi wyjść 0

**To jest twoja praca, dopóki temat nie padnie.** Nie piszesz kodu rozwiązania,
bo jeszcze nie wiesz, co budujesz. Pusty `check.sh` z `PHASE=0` kończy 1 — to
jest cel, nie błąd.

Jeśli nie wisz, co wpisać w sekcji 3 — napisz test, który sprawdza najmniejszą
rzecz, którą twój kawałek musi robić. Zepsuj ją i zobacz, czy test łapie.

## 3. Temat pada (09:00)

System-1 bierze temat i odpala research. **Ty nie czekasz** — kończysz `check.sh`.

## 4. Kapsuła gotowa (~09:58)

```bash
cd <repo-rozwiazania>      # tam, gdzie leży KAPSULA.md
cat KAPSULA.md
```

Sprawdź **swoją** linię w sekcji 5: czy wiesz, co robisz i na co czekasz?
Jeśli nie — to jest jedyny moment, żeby to powiedzieć.

## 5. Start (10:00)

```bash
cd ~/w1-kawalek
omp          # albo claude, codex — cokolwiek, w czym pracujesz
```

Pierwsze zdanie do agenta:

> **Przeczytaj `KAPSULA.md`. Potem uruchom `./check.sh`. Potem zacznij.**

Potem: kod → `./check.sh` → review → merge. Non-stop, aż do freeze.

---

## Trzy rzeczy, które musisz wiedzieć

1. **`check.sh` zielony = wjeżdżasz na `main`.** Sam. Czekasz tylko na swoje
   zależności z kolumny „Czeka na" w kapsule.
2. **Konflikt w pliku interfejsu → nie ruszaj.** Zapisz, wróć do pracy, raport
   na sync.
3. **Kapsuła może być zła.** Jeśli myślisz *„moment, to nie jest to, o co
   chodzi"* — mówisz natychmiast, nie na sync. To jest najważniejszy głos w
   systemie i nikt inny go nie wyda.

---

## Nie czytasz

Niczego, czego nie wskazuje `AGENTS.md` ani kapsuła. Reguły masz w `AGENTS.md` §4.
Dokumenty z repo blueprintu (`1-RESEARCH.md`, `2-BUILD.md`, `3-CHEATSHEET.md`) nie są
częścią twojej pracy.
