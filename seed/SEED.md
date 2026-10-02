# SEED.md — co to jest i jak uruchomić

**Jedno polecenie, które tworzy całe środowisko hackathonu:**

```bash
bash seed/bootstrap.sh
```

To tworzy repo rozwiązania i pięć worktree — po jednym na osobę. Każde ma swój
`check.sh`. Do `main` merguje się z każdego worktree.

**Bez pytań do człowieka.** Każdy element ma wartość domyślną:

| Element | Domyślnie |
|---|---|
| Repo | `~/hackathon-rozwiazanie` (argument: `bash seed/bootstrap.sh /path`) |
| Nazwy katalogów | `~/w1-kawalek` … `~/w5-kawalek` |
| Branch per katalog | `w1` … `w5` |
| Branch docelowy merge | `main` |
| `STAN` w `AGENTS.md` | `PRZYGOTOWANIE` — do zmiany przez człowieka |
| Sekrety, konta, sieć | **nie wymagane** |

---

## Co dostajesz

```text
~/hackathon-rozwiazanie/     ← repo rozwiązania, main
├── AGENTS.md                ← kontekst agenta (wczytywany na starcie sesji)
├── KAPSULA.md               ← szablon, wypełnia system-1 w sobotę
└── .git

~/w1-kawalek/                ← worktree + branch w1 + check.sh
~/w2-kawalek/                ← worktree + branch w2 + check.sh
~/w3-kawalek/                ← worktree + branch w3 + check.sh
~/w4-kawalek/                ← worktree + branch w4 + check.sh
~/w5-kawalek/                ← worktree + branch w5 + check.sh
```

Każdy katalog ma `check.sh` w **roocie**. Wywołujesz `./check.sh` z katalogu
worktree. Nie ma podkatalogu `w1/` wewnątrz — to jest cały katalog.

---

## Kiedy to odpalić

**Piątek wieczorem**, raz. Sprawdź wynik komendami z
[`VERIFY.md`](VERIFY.md) — to 5 minut i musi być zielone przed snem.

Sobota rano: jeśli coś nie gra, odpal jeszcze raz. **Jest idempotentny** —
drugi raz nie niszczy katalogów, nie nadpisuje wypełnionej kapsuły ani
zmodyfikowanego `check.sh`.

---

## Czego ten seed nie robi

- **Nie wymyśla tematu.** Kapsuła jest pustym szablonem.
- **Nie zakłada zdalnego repo.** Jeśli chcecie pushować, dodajcie `git remote add
  origin <url>` w `~/hackathon-rozwiazanie`. Bez tego praca jest lokalna — a
  `check.sh` i tak działa.
- **Nie instaluje narzędzi.** Wymaga `git`. Język i framework wybieracie w
  sobota, `check.sh` jest językowo neutralny.
- **Nie tworzy ochrony brancha.** Jeśli `main` ma być chroniony, zróbcie to
  ręcznie w interfejsie GitHub.

---

## Kolejność czytania w sobotę

1. `seed/templates/START-HERE.md` — pierwsze 30 minut
2. `KAPSULA.md` — gdy system-1 ją wypełni (~09:58)
3. `AGENTS.md` §4 — reguły, które obowiązują zawsze

Pliki `1-RESEARCH.md`, `2-BUILD.md`, `3-CHEATSHEET.md` są w blueprint repo. Pierwsze
dwa czyta się **gdy chce się zrozumieć dlaczego**, trzeci to zegar dla człowieka.
Nie są potrzebne do startu.

---

## Jeśli coś poszło nie tak

| Objaw | Naprawa |
|---|---|
| `FAIL: 'git' not found in PATH` | zainstaluj git |
| `fatal: a branch named 'w1' already exists` | stara wersja. Teraz bootstrap zakłada istniejący branch zamiast failować — zaktualizuj seed |
| Katalog `~/w1-kawalek` istnieje, ale nie ma `check.sh` | `cp seed/templates/check.sh.example ~/w1-kawalek/check.sh && chmod +x ~/w1-kawalek/check.sh` |
| Chcę inną nazwę katalogu | zedytuj `PIECES=(...)` na górze `bootstrap.sh` **przed** pierwszym odpaleniem |
| Chcę usunąć wszystko i zacząć od nowa | `git -C ~/hackathon-rozwiazanie worktree prune` i usuń katalogi ręcznie. **Nie uruchamiaj bootstrapa, żeby wyczyścić** — on nie usuwa |
