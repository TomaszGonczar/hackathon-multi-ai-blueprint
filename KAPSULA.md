<!--
  KAPSULA.md — jedyny plik przekazywany z systemu 1 do systemu 2.
  W tym repo jest SZABLONEM. W sobotę nadpisujecie go realnymi odpowiedziami.
  Wypełnia go system 1 po tym, jak zespół wybierze opcję na głos.
  Komentarze <!-- --> usuń przy wypełnianiu — zostaje sam dokument.
-->

# KAPSULA

**Temat:** <!-- dosłownie, jak ogłoszono -->
**Wybrana opcja:** <!-- jedna nazwa, bez dyskusji -->
**Wybrano:** <!-- kto, kiedy, na głos -->
**System 2 start:** <!-- kiedy można brać się do budowy -->

---

## 1. Co budujemy

<!-- Jedno–dwa zdania. Tyle, ile da się powiedzieć bez czytania reszty.
     Ma być da się obalić. Jeśli nie da się — wróć do researchu. -->



---

## 2. Dlaczego ta opcja

<!-- Trzy zdania. Dlaczego TA, a nie pozostałe dwie.
     Wystarczy, żeby ktoś, kto nie był przy brainstormie, nie zastanawiał się nad tym. -->

**Odrzucone:**
- <!-- opcja + jedno zdanie czemu nie -->
- <!-- opcja + jedno zdanie czemu nie -->

---

## 3. Co wiemy

<!-- Fakty istotne dla BUDOWY. Każdy z linkiem. 5–15 punktów.
     Przy godzinowym researchu będzie ich mniej i będą mniej pewne — bądźmy tego świadomi. -->

- <!-- fakt --> — źródło: https://adres

---

## 4. Czego nie wiemy

<!-- RYZYKA. Przy jednej godzinie researchu to jest najważniejsza sekcja.
     System 1 wypełnia ją sam — wy nie macie czasu, a wiecie mniej.
     Ktoś na pewno na to spojrzy w nocy. Lepiej żeby to był wybór, a nie niespodzianka. -->

- <!-- pytanie bez odpowiedzi -->

---

## 5. Pięć kawałków

<!-- TO JEST TO, CO PILNUJE KOLIZJI I KOLEJNOŚCI MERGÓW.

     Katalogi fizycznie osobne: git worktree na osobę. Dwa kawałki nie mogą
     mieć tego samego pliku — jeśli mają, to nie jest podział, to jest jego brak.

     KOLUMNA "CZEKA NA" — to kolejność wjeżdżania na main. Maszyna czyta ją
     i NIE PYTA. Kawałek 4 czeka na 1 i 2, więc 4 nie wjedzie, dopóki 1 i 2
     nie będą na main. Jeśli nie wypełnisz tej kolumny, maszyna stanie
     i będzie czekać na człowieka, a to dokładnie tego nie chcemy.

     Popatrz: czy da się ułożyć te pięć wierzchołków tak, żeby NIE było cyklu?
     Cykl = deadlock = maszyna czeka w nieskończoność. -->

| # | Katalog | Wejście / wyjście | Robi | Nie rusza | **Czeka na** |
|---|---|---|---|---|---|
| 1 | `w1-.../` | we: <!-- --> / wy: <!-- --> | | | — |
| 2 | `w2-.../` | we: <!-- --> / wy: <!-- --> | | | — |
| 3 | `w3-.../` | we: <!-- --> / wy: <!-- --> | | | 1, 2 |
| 4 | `w4-.../` | we: <!-- --> / wy: <!-- --> | | | 1 |
| 5 | `w5-.../` | we: <!-- --> / wy: <!-- --> | | | 1, 2, 3, 4 |

**Pliki interfejsu** — pliki, których dotyka więcej niż jeden kawałek. Konflikt
w tych plikach maszyna **nie rozwiązuje**:

- `<!-- np. src/api/types.py -->`

---

## 6. Jak sprawdzamy

<!-- JEDNA KOMENDA NA KAWAŁEK. Exit 0 = gotowe = maszyna może wjechać na main.
     Ta sekcja musi być wypełniona PRZED startem systemu 2. -->

```bash
# przykład — właściwe komendy wpisujecie wy
./w1/check.sh && ./w2/check.sh && ./w3/check.sh && ./w4/check.sh && ./w5/check.sh
echo $?   # 0 = wszystko gotowe
```

**Test, który nic nie łapie, nie jest testem.** Przed startem: zepsujcie jeden
kawałek na złoto i sprawdźcie, że `check.sh` to zauważa.

---

<!--
DO SYSTEMU 2 — nie edytuj powyższego.
  1. Przeczytaj cały ten plik. To wszystko, co musisz wiedzieć.
  2. Zrób ./<swoj>/check.sh zanim napiszesz pierwszą linię kodu.
  3. Pracuj w swoim katalogu. Push co 30 min i zawsze przed snem.
  4. Zielony test → review → PRÓBUJ WJEŻCHAĆ NA MAIN.
       - twoje zależności (kolumna "Czeka na") jeszcze nie na main → CZEKAJ, wracaj do pracy
       - konflikt mechaniczny → rozwiąż sam
       - konflikt w pliku interfejsu → ZAPISZ, nie ruszaj, wróć do pracy, raport na sync
       - review zgłasza brak w poprawności → popraw, nie wjeżdżaj
  5. Nie pytaj systemu 1 o radę — jest tu wszystko. Brakuje czegoś?
     Dopisz do sekcji 4 i jedź dalej.
-->
