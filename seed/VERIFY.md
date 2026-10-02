# VERIFY.md — jak sprawdzić, że seed działa

**Czas:** 10 minut na czystej maszynie. Licznik startuje przy komendzie z
sekcji 1.

**Cel:** pięć worktree, z których każdy ma kontekst agenta i `check.sh`,
a bramka kolejności mergów faktycznie blokuje zależne kawałki.

---

## 1. Jedna komenda (30 s)

```bash
bash seed/bootstrap.sh
```

Sekcja na końcu wyjścia to checklista weryfikacji. Wszystko poniżej powtarza ją
krok po kroku.

## 2. Pięć katalogów (30 s)

```bash
ls -d ~/w1-kawalek ~/w2-kawalek ~/w3-kawalek ~/w4-kawalek ~/w5-kawalek
```

Oczekiwane: pięć linii. Brak którejkolwiek = FAIL.

## 3. Kontekst agenta JEST W ŚRODKU każdego worktree (1 min)

To nie jest kosmetyka. Agent pracuje z worktree jako katalogiem roboczym — jeśli
`AGENTS.md` i `KAPSULA.md` nie są na jego branchu, nie wczyta ani reguł, ani
kapsuły, i cały mechanizm „kapsuła to jedyny przewód" po cichu nie działa.

```bash
for n in w1-kawalek w2-kawalek w3-kawalek w4-kawalek w5-kawalek; do
  printf "%s: " "$n"; ls ~/$n/AGENTS.md ~/$n/KAPSULA.md 2>/dev/null | wc -l
done
```

Oczekiwane: pięć razy `2`. Każde `0` albo `1` = FAIL.

## 4. `check.sh` istnieje i jest wykonywalny (30 s)

```bash
for n in w1-kawalek w2-kawalek w3-kawalek w4-kawalek w5-kawalek; do
  [ -x ~/$n/check.sh ] && echo "$n: OK" || echo "$n: FAIL"
done
```

## 5. Faza 0 kończy 1 (1 min)

`check.sh`, które zawsze kończy 0, nie jest testem.

```bash
for n in w1-kawalek w2-kawalek w3-kawalek w4-kawalek w5-kawalek; do
  bash ~/$n/check.sh >/dev/null 2>&1; printf "%s -> %s\n" "$n" "$?"
done
```

Oczekiwane: pięć razy `-> 1`, z komunikatem o fazie 0.

## 6. Po wypełnieniu kończy 0 (1 min)

```bash
# UWAGA: na macOS `sed -i` bez argumentu pada ("bad flag in substitute
# command"). Forma z `.bak` działa i na macOS (BSD), i na Linuksie (GNU).
sed -i.bak 's/PHASE=0/PHASE=1/' ~/w1-kawalek/check.sh && rm -f ~/w1-kawalek/check.sh.bak
bash ~/w1-kawalek/check.sh; echo "exit=$?"     # oczekiwane: 0
sed -i.bak 's/PHASE=1/PHASE=0/' ~/w1-kawalek/check.sh && rm -f ~/w1-kawalek/check.sh.bak
```

(Otwarcie pliku edytorem i zmiana `PHASE=0` na `PHASE=1` też jest w porządku —
to jedno słowo.)

Sekcje 1–3 są jeszcze pustymi `echo`, dlatego przechodzi. Ten krok sprawdza, że
**bramka fazy działa w obie strony**.

## 7. Bramka sekretów (1 min)

```bash
cd ~/w1-kawalek
echo "API_KEY=supersecret" > test-secret.txt
git add test-secret.txt
bash ./check.sh; echo "exit=$?"     # oczekiwane: 1
git reset -q test-secret.txt && rm test-secret.txt
```

Działa **w obu fazach** — sekret w fazie 0 to nadal sekret.

## 8. Bramka kolejności mergów NIE jest fałszywie prawdziwa (2 min)

To jest najważniejszy test po numerze 3. Wszystkie branche powstają tuż po
`main`, więc bez znacznika startowego każdy z nich jest **przodkiem** `main` —
i `git merge-base --is-ancestor` zgłasza każdy kawałek jako „już zmergowany".
Kawałek z zależnościami mógłby wtedy wjechać pierwszy.

```bash
cd ~/hackathon-rozwiazanie
for b in w1 w2 w3 w4 w5; do
  if git merge-base --is-ancestor $b main; then echo "$b: ZLE (wyglada na zmergowany)"; else echo "$b: OK"; fi
done
```

Oczekiwane: **pięć razy `OK`**. Jakiekolwiek `ZLE` = FAIL — kolejność mergów nie
działa.

## 9. Bramka odblokowuje po zmergowaniu zależności (2 min)

Symulacja: zmerguj `w1` i sprawdź, że `w3` nadal czeka, ale `w1` już jest.

```bash
cd ~/w1-kawalek
git add -A && git -c user.name=t -c user.email=t@t commit -qm "w1" --allow-empty
cd ~/hackathon-rozwiazanie
git merge --no-ff -q w1 -m "merge w1"
git merge-base --is-ancestor w1 main && echo "w1: TAK (poprawnie)"
git merge-base --is-ancestor w2 main || echo "w2: NIE  <- w3/w4 nadal czekaja (poprawnie)"
git merge-base --is-ancestor w3 main || echo "w3: NIE  <- poprawnie"
```

Oczekiwane: `w1: TAK`, `w2: NIE`, `w3: NIE`.

## 10. Idempotentność (1 min)

```bash
bash seed/bootstrap.sh
```

Oczekiwane: te same pięć katalogów, kapsuła nienaruszona, komunikat
*„worktree exists (skipping)"*, i **brak podwójnych znaczników**:

```bash
cd ~/hackathon-rozwiazanie
git log --format=%s w1 | grep -c "seed: w1-kawalek marker"   # oczekiwane: 1
```

---

## Wynik

| # | Test | Zaliczone, gdy |
|---|---|---|
| 1 | `bootstrap.sh` kończy 0 | brak `FAIL:` w wyjściu |
| 2 | 5 katalogów | `ls -d` zwraca 5 |
| 3 | kontekst agenta w worktree | 5x `2` (AGENTS.md + KAPSULA.md) |
| 4 | `check.sh` wykonywalny | 5x OK |
| 5 | faza 0 kończy 1 | 5x exit 1 |
| 6 | faza 1 kończy 0 | exit 0 |
| 7 | sekret łapany (obie fazy) | exit 1 |
| 8 | bramka nie fałszywie prawdziwa | 5x OK |
| 9 | bramka odblokowuje po zależnościach | `w1: TAK`, `w2: NIE` |
| 10 | idempotentność | brak duplikatów znaczników |

**Wszystko zielone = seed działa. Czerwone = nie zaczynacie hackathonu.**

Sprawdzone end-to-end na czystym `$HOME`: bootstrap → budowa prawdziwego kawałka
w `w1` → `check.sh` zielone → merge `w1` na `main` → `w3`/`w4` nadal czekają na
`w2` → po merge `w2` odblokowane, `w5` nadal czeka na `w3`,`w4`.

---

## Jeśli coś jest czerwone

| Objaw | Naprawa |
|---|---|
| brak `AGENTS.md` w worktree | branch powstał przed commitem kontekstu — usuń katalog i odpal bootstrap ponownie |
| bramka mówi `ZLE` na starcie | brak znacznika startowego na branchu — usuń katalog i odpal bootstrap ponownie |
| `fatal: a branch named 'w3' already exists` | stara wersja seeda — zaktualizuj |
| katalog istnieje, ale nie jest worktree | `git -C ~/hackathon-rozwiazanie worktree prune`, potem bootstrap |
| `check.sh` w fazie 0 kończy 0 | `grep PHASE ~/w1-kawalek/check.sh` — musi być `PHASE=0` |

---

## Czego ten test NIE sprawdza

- **Nie sprawdza, że umiecie napisać dobry test.** To robicie w sobotę.
- **Nie sprawdza, że kapsuła jest wypełniona.** Ona jest pustym szablonem —
  system-1 wypełnia ją w sobotę po wyborze.
- **Nie sprawdza uprawnień do remote'a.** Do tego `git push origin main --dry-run`
  po dodaniu remote'a.
- **Nie sprawdza języka ani frameworka.** `check.sh` jest neutralny.