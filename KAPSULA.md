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
     Nie pełne uzasadnienie — wystarczy, żeby ktoś, kto nie był przy brainstormie,
     zrozumiał dlaczego nie ma się nad tym zastanawiać. -->

**Odrzucone:**
- <!-- opcja + jedno zdanie czemu nie -->
- <!-- opcja + jedno zdanie czemu nie -->

---

## 3. Co wiemy

<!-- Fakty istotne dla BUDOWY. Każdy z linkiem. 5–15 punktów.
     Bez linku nie wchodzi — oznacz [niepotwierdzone] i wiedź, że budujecie na tym. -->

- <!-- fakt --> — źródło: https://adres

---

## 4. Czego nie wiemy

<!-- Ryzyka. Świadomie zostawione otwarte.
     Ktoś na pewno na to spojrzy w nocy. Lepiej, żeby to był wybór, a nie niespodzianka. -->

- <!-- pytanie bez odpowiedzi -->

---

## 5. Pięć kawałków

<!-- TO JEST TO, CO PILNUJE KOLIZJI. Nie „kto czym się zajmuje" — tylko
     kto pisze w JAKIM katalogu i co z niego wystawia.
     Jeśli dwa kawałki mają ten sam plik — to nie jest podział, to jest brak podziału.
     Katalogi fizycznie osobne: git worktree na osobę. -->

| # | Katalog | Wpisuje/wyjście | Robi | Nie rusza |
|---|---|---|---|---|
| 1 | `w1-.../` | wejście: <!-- --> / wyjście: <!-- --> | | |
| 2 | `w2-.../` | wejście: <!-- --> / wyjście: <!-- --> | | |
| 3 | `w3-.../` | wejście: <!-- --> / wyjście: <!-- --> | | |
| 4 | `w4-.../` | wejście: <!-- --> / wyjście: <!-- --> | | |
| 5 | `w5-.../` | wejście: <!-- --> / wyjście: <!-- --> | | |

<!-- Podpisz to na kartce i powiedz na głos: "jeśli dwa kawałki chcą tego samego pliku,
     zatrzymujemy się teraz, nie na merge". -->

---

## 6. Jak sprawdzamy

<!-- JEDNA KOMENDA NA KAWAŁEK. Exit 0 = gotowe.
     Ta sekcja musi być wypełniona PRZED startem systemu 2. Bez niej system 2 nie startuje. -->

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
  4. Nie pytaj systemu 1 o radę — jest tu wszystko, czego potrzebujesz.
     Jeśli czegoś brakuje: dopisz do sekcji 4 i jedz dalej.
-->
