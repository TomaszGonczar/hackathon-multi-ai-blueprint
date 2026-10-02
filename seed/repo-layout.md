# repo-layout.md — struktura katalogów, branchy i worktree

---

## Worktree = kawałek

Każda osoba ma **jeden katalog, jeden branch, jedno `check.sh`**. Katalog jest
worktree — pełnoprawnym checkoutem repo, nie podlinkowanym podkatalogiem.

```text
~/w1-kawalek/     branch: w1     ← czeka na: —
~/w2-kawalek/     branch: w2     ← czeka na: —
~/w3-kawalek/     branch: w3     ← czeka na: w1, w2
~/w4-kawalek/     branch: w4     ← czeka na: w1, w2
~/w5-kawalek/     branch: w5     ← czeka na: w1, w2, w3, w4
```

Kolumna „Czeka na" jest w `KAPSULA.md` sekcja 5. **To jest kolejność wjeżdżania na
`main`, czytana maszynowo.** Powyższa to wartość domyślna seeda; jeśli zespół
zmienia podział, wpisuje to do kapsuły, a nie tutaj.

**Cykl = deadlock.** Jeśli `w3` czeka na `w5`, a `w5` na `w3` — maszyna czeka w
nieskończoność i nic o tym nie wie. Zanim startujecie, sprawdźcie na kartce, że
da się te pięć ułożyć bez cyklu.

---

## Root vs katalog roboczy

```text
~/w1-kawalek/              ← TUTAJ pracujesz (cwd)
├── .git                   ← plik, nie katalog — wskaźnik na ~/hackathon-rozwiazanie/.git
├── check.sh               ← w roocie worktree, wywołujesz ./check.sh
└── <twoje pliki>
```

**`check.sh` jest w roocie worktree.** Nie ma `~/w1-kawalek/w1/check.sh`. Ktoś,
kto szuka podkatalogu, nie znajdzie go — to jest cel, bo usuwa dwuznaczność
między katalogiem a kawałkiem.

---

## Repo rozwiązania

```text
~/hackathon-rozwiazanie/
├── .git/                  ← wszystkie branche, cała historia
├── AGENTS.md              ← wczytywany na starcie każdej sesji
├── KAPSULA.md             ← wypełniana w sobotę przez system-1
└── main                   ← cel merge'ów
```

**`AGENTS.md` i `KAPSULA.md` leżą w roocie repo rozwiązania**, nie w worktree i
nie w repo blueprintu. Twój agent wczytuje je stąd, bo tu jest jego cwd.

To jest ten sam plik dla wszystkich pięciu — edytuje go tylko system-1 (do
T+1:00) albo człowiek (na sync i freeze).

---

## Relacja branch → main

```text
w1 ──merge──► main
w2 ──merge──► main
w3 ──merge──► main   (dopiero gdy w1 i w2 są na main)
w4 ──merge──► main   (dopiero gdy w1 i w2 są na main)
w5 ──merge──► main   (dopiero gdy w1, w2, w3 i w4 są na main)
```

Merge jest wykonywany **przez agenta, w jego pętli** — nie ma bota, nie ma crona,
nie ma hooka. Reguła jest w `AGENTS.md` §4.4.

### Jak sprawdzić, czy twoje zależności są już na main

```bash
git fetch origin main
for dep in 1 2; do
  git merge-base --is-ancestor origin/w$dep origin/main || {
    echo "czekam na w$dep — wracam do pracy"
  }
done
```

`git merge-base --is-ancestor` działa na **commitach**, nie na nazwach. Jeśli
merge na main był squashowany, ten test mimo wszystko przechodzi — sprawdzone.

### Jeśli nie ma zdalnego repo

Wszystko powyżej działa lokalnie, tylko bez `origin/`. Wtedy `git fetch origin main`
zamień na nic, a `origin/main` na `main`. **Push co 30 minut i tak obowiązuje** —
wymaga dodania remote'a (`git remote add origin <url>`), inaczej Wasz backup nie
istnieje.

---

## Nazwy

Nazwa katalogu to sygnał, który agent czyta, zanim otworzy plik. `w1/` nie mówi
nic. `w1-detekcja-anomalii/` mówi wszystko.

Dlatego seed używa neutralnych `w1-kawalek` … `w5-kawalek` **na start**. W
sobotę, gdy kapsuła jest wypełniana (~0:55), system-1 wpisuje realne nazwy do
sekcji 5, a wy zmieniacie nazwy katalogów:

```bash
git -C ~/hackathon-rozwiazanie worktree move ~/w1-kawalek ~/w1-detekcja-anomalii
git -C ~/hackathon-rozwiazanie branch -m w1 w1-detekcja-anomalii
```

Zróbcie to **zanim** ktokolwiek napisze linię kodu. Potem nazwa brancha jest w
historii i zmiana kosztuje.

Jeśli zmienisz nazwę katalogu, `AGENTS.md §4.1` nie jest do aktualizacji —
reguła mówi *„cd ~/w<N>-<nazwa>"*, a nie konkretną nazwę.

---

## Czego tu nie ma

- **Żadnego podkatalogu `src/` albo `tests/` narzuconego z góry.** Język i
  strukturę wybieracie w sobotę.
- **Żadnego wymogu sieci.** Bootstrap i `check.sh` działają offline.
- **Żadnego narzuconego remote'a.** Dodajecie, jeśli chcecie pushować.
