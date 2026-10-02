# VERIFY.md — jak sprawdzić, że seed działał

**Czas:** 10 minut na czystej maszynie. Licznik startuje przy komendzie z
sekcji 1.

**Cel:** pięć działających katalogów z `check.sh`, które kończą przewidywalnym
kodem.

---

## 1. Jedna komenda (30 s)

```bash
bash seed/bootstrap.sh
```

Sekcja na końcu wyjścia to checklista weryfikacji. Wszystko poniżej powtarza ją
krok po kroku.

## 2. Pięć katalogów (1 min)

```bash
ls -d ~/w1-kawalek ~/w2-kawalek ~/w3-kawalek ~/w4-kawalek ~/w5-kawalek
```

Oczekiwane: pięć linii, każda to katalog. Brak którejkolwiek = FAIL.

## 3. `check.sh` istnieje i jest wykonywalny (1 min)

```bash
for n in w1-kawalek w2-kawalek w3-kawalek w4-kawalek w5-kawalek; do
  [ -x ~/$n/check.sh ] && echo "$n: OK" || echo "$n: FAIL"
done
```

Oczekiwane: pięć OK.

## 4. `check.sh` w fazie 0 kończy 1 (2 min)

To jest najważniejszy test. `check.sh`, które zawsze kończy 0, nie jest testem.

```bash
bash ~/w1-kawalek/check.sh
echo "exit=$?"     # oczekiwane: 1
```

Powinien wypisać:

```text
FAIL: check.sh jest w fazie 0 — sekcje 1-3 nie wypelnione
```

**Każdy z pięciu musi tak zrobić.** Skrypt, który kończy 0 przed wypełnieniem,
oznacza, że w sobotę ktoś zacznie kodować bez testu — a `AGENTS.md §4.2`
(*„test zanim kod"*) staje się martwą regułą.

## 5. Po wypełnieniu kończy 0 (2 min)

Symulacja: zmień `PHASE=0` na `PHASE=1` i sprawdź.

```bash
sed -i 's/PHASE=0/PHASE=1/' ~/w1-kawalek/check.sh
bash ~/w1-kawalek/check.sh
echo "exit=$?"     # oczekiwane: 0
```

Powinien wypisać:

```text
== 1. buduje się ==
== 2. testy ==
== 3. czy test cos lappie ==
OK
```

**Uwaga:** sekcje 1–3 są jeszcze pustymi echo — dlatego przechodzi. W sobotę
wypełniacie je prawdziwymi komendami i wtedy test ma wartość. Ten krok sprawdza
tylko, że **bramka fazy działa w obie strony**: 0 → 1, 1 → 0.

Przywróć:

```bash
sed -i 's/PHASE=1/PHASE=0/' ~/w1-kawalek/check.sh
```

## 6. Bramka sekretów działa (2 min)

```bash
cd ~/w1-kawalek
echo "API_KEY=supersecret" > test-secret.txt
git add test-secret.txt
bash ./check.sh
echo "exit=$?"     # oczekiwane: 1
```

Powinien wypisać:

```text
== 4. brak sekretów ==
1:+API_KEY=supersecret
FAIL: sekret w staged diff
```

Sprzątanie:

```bash
git reset -q test-secret.txt
rm test-secret.txt
```

## 7. Idempotentność (1 min)

Odpal drugi raz:

```bash
bash seed/bootstrap.sh
```

Oczekiwane: te same pięć katalogów, żaden plik nie skasowany, kapsuła
nienaruszona. Komunikaty mówią *„worktree exists (skipping)"* i *„nothing new
to commit"*.

## 8. Kontekst agenta na miejscu (30 s)

```bash
ls ~/hackathon-rozwiazanie/AGENTS.md ~/hackathon-rozwiazanie/KAPSULA.md
grep "^STAN:" ~/hackathon-rozwiazanie/AGENTS.md
```

Oczekiwane: oba pliki istnieją, `STAN:` to `PRZYGOTOWANIE`.

---

## Wynik

| # | Test | Zaliczone, gdy |
|---|---|---|
| 1 | `bootstrap.sh` kończy 0 | brak `FAIL:` w wyjściu |
| 2 | 5 katalogów | `ls -d` zwraca 5 |
| 3 | `check.sh` wykonywalny | 5x OK |
| 4 | faza 0 kończy 1 | 5x exit=1 |
| 5 | faza 1 kończy 0 | exit=0 i `OK` |
| 6 | sekret łapany | exit=1 i `FAIL: sekret` |
| 7 | idempotentność | drugi run nie zmienia niczego |
| 8 | kontekst na miejscu | 2 pliki + `STAN: PRZYGOTOWANIE` |

**Wszystko zielone = seed działa. Czerwone = nie zaczynacie hackathonu.**

---

## Jeśli coś jest czerwone

| Objaw | Naprawa |
|---|---|
| `fatal: a branch named 'w3' already exists` | stara wersja seeda — zaktualizuj |
| Katalog istnieje, ale nie jest worktree | `git -C ~/hackathon-rozwiazanie worktree prune`, potem odpal bootstrap jeszcze raz |
| `check.sh` w fazie 0 kończy 0 | `PHASE` nie jest `0` — sprawdź `grep PHASE ~/w1-kawalek/check.sh` |
| `check.sh` po wypełnieniu kończy 1 | sekcje 1–3 nie są wypełnione, albo są tam komendy, które nie przechodzą |
| Brak `AGENTS.md` w roocie repo | `cp seed/templates/AGENTS.md ~/hackathon-rozwiazanie/AGENTS.md` |

---

## Czego ten test NIE sprawdza

- **Nie sprawdza, że umiecie napisać dobry test.** To robicie w sobotę.
- **Nie sprawdza, że kapsuła jest wypełniona.** Ona jest pustym szablonem —
  system-1 wypełnia ją w sobotę po wyborze.
- **Nie sprawdza, że macie uprawnienia do remote'a.** Do tego służy
  `git push origin main --dry-run`, odpalony ręcznie po dodaniu remote'a.
- **Nie sprawdza języka ani frameworka.** `check.sh` jest neutralny, bo język
  wybieracie w sobotę.
