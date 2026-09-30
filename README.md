# Dwa systemy, jeden plik między nimi

Hackathon w sobotę. Temat nieznany do godziny zero. Pięć osób, ~20 sesji agentów,
dwa dni. **System 2 leci non-stop.**

**To jest cały pomysł. Reszta pliku to jak go wykonać.**

Poprzednia wersja tego repo miała 3 391 linii i dwa systemy, które kosztowały więcej
niż dawały. Ta ma [cztery pliki](#pliki) i zero mechanizmów, które trzeba utrzymywać.

---

## Zakład

Twój kumpel ma **2× Claude Pro i 1× ChatGPT**. Projekt jest zakładem, że **moc
obliczeniowa i tokeny w najlepszych modelach są do zdobycia i mają być wydane.**
Większość tego, co normalnie wygląda na rozsądne oszczędzanie, tutaj jest błędem.

**Jedyne, co jest naprawdę wąskie, to nie tokeny:**

| Wąskie | Nie wąskie |
|---|---|
| **Uwaga** — kto czyta, kto decyduje | tokeny |
| **Kontekst jednej sesji** — im dłużej, tym gorszej myśli | liczba sesji |
| **Kolizje** — dwóch pisze w jedno miejsce | czas działania |
| **Synteza** — jeden lead czyta 10 wyników | research |

---

## System 1 — research i brainstorm. **Jedna godzina.**

**Jeden laptop. OMP. 60 minut. Nikt nie koduje.**

```
0:00 ─ 0:35  research: 5 sesji równolegle, każda zapisuje do swojego pliku
0:35 ─ 0:48  brainstorm: 3 sesje, 3 różne wejścia → 3 propozycje
0:48 ─ 0:58  ZESPÓŁ WYBIERA opcję na głos → system 1 wpisuje do kapsuły
0:58 ─ 1:00  brief czytany na głos
              ▼
          KAPSULA.md
```

Godzina zamiast dwóch. Pięć sesji zamiast sześciu–dziesięciu. Konsekwencja jest
prosta i warto ją znać: **zrozumienie tematu jest słabsze.** Jeśli temat okaże się
trudniejszy niż myśleliście, zobaczycie to przy godzinie 3, nie przy 1,5. Dlatego
sekcja 4 kapsuły („czego nie wiemy") jest ważniejsza niż była — i wypełnia ją
system 1, nie wy.

Reszta zespołu w tej godzinie **nie czeka** — robi swoje `check.sh`, o których jest
mowa w `2-BUDOWA.md`.

## Kapsuła — jedyny przewód

```markdown
# KAPSULA.md

## 1. Co budujemy            ← zespół wybrał, system 1 tylko podsunął opcje
## 2. Dlaczego ta opcja      ← 3 zdania + dlaczego odrzucono pozostałe
## 3. Co wiemy               ← fakty, każdy z linkiem
## 4. Czego nie wiemy        ← ryzyka, świadomie zostawione
## 5. Pięć kawałków          ← kto, co, jaki katalog, czeka na kogo   ← KLUCZ
## 6. Jak sprawdzamy         ← jedna komenda, exit 0 albo nie
```

Sekcja 5 ma teraz kolumnę **„Czeka na"** i to nie jest kosmetyka — **to kolejność
mergów, maszynowo czytelna.** Bez niej maszyna nie wie, co może wjechać na `main`
wcześniej niż inne, i zatrzymuje się na pytaniu do człowieka. Patrz
[`2-BUDOWA.md`](2-BUDOWA.md).

### Dlaczego kapsuła, a nie rozmowa

System 1 i system 2 dzieli jedno okno czasu i jedną brakującą rzecz: **wiedzę**.
Agent z systemu 1 nie zapyta agenta z systemu 2, a człowiek nie przekaże researchu
ustami o 2:00 w nocy.

Dlatego jedyna rzecz, która **musi** przetrwać, to plik. I dlatego — patrz niżej —
nie potrzebujecie pamięci.

## Dwa dni = brak pamięci

System żyje 48 godzin. **Dlatego nie projektujemy pamięci.**

Wypada: architektura notatek, kompakcji, wznawiania sesji, pamięć agenta,
checkpointy, „co przeżywa między dniami". Nic z tego nie ma sensu, gdy jutro
zaczynamy od nowa.

Konsekwencja jest wygodna: **każda sesja startuje z czystym kontekstem i to jest OK.**
Sesja, która pamięta trzy godziny rozmowy, myśli gorzej niż nowa. Nowa czyta
kapsułę i ma wszystko.

---

## System 2 — budowa, non-stop

**Pięć osób, pięć laptopów, pięć sesji OMP. Opcjonalnie kolejne do review.**

**Mierzyna merguje sama.** Każdy agent, po zielonym `check.sh`, próbuje wjechać na
`main`. Jeśli jego zależności jeszcze nie są na `main` — **czeka i wraca do pracy.**
Nie pyta. Nie blokuje zespołu.

```
KAPSULA.md → 5 osób × 1–2 sesje → worktree na osobę → zielony test → MACHINA MERGUJE
                                                                            │
                                            czeka na inne moduły ◄──────────┤
                                                                            ▼
                                                          człowiek: sync co 2 h i freeze
```

### Jedno zdanie, które trzeba powiedzieć na głos przed startem

> **Maszyna może zmergować wszystko. Nie może powiedzieć, co wysyłacie.**

Dlatego człowiek wchodzi **dwa razy**: na sync (co 2 h) i na freeze. Wszystko
pomiędzy jest maszynowe. Jeśli to jest ustalone, to jest kompromis — człowiek
odpowiada za wynik, maszyna wykonuje. Slajd IBM-a z 1979, który cytuje Simon Willison,
nie zmienia się przez to, że merge jest automatyczny: *„A computer can never be held
accountable."* Pytanie brzmi tylko, **gdzie** człowiek wchodzi — i odpowiedź brzmi:
tam, gdzie decyduje się, co jest ważne, a nie gdzie przesuwa się kod.

---

## Cztery reguły

### 1. Jedna kapsuła, jeden wybór

System 1 podsunie opcje. **Zespół wybiera na głos.** System 1 wpisuje wybór do
kapsuły i milczy. System 2 buduje wybrane i **nie wraca po radę**.

### 2. Jeden katalog na osobę, kolejność mergów w kapsule

Pięć `git worktree`, zero wspólnych plików — kolizji nie ma, bo nie ma powierzchni.
Kolejność wjeżdżania na `main` opisuje tabela w sekcji 5 kapsuły, kolumna „Czeka na".

### 3. Jeden test na kawałek

Jedna komenda. Exit 0 = gotowe. **Bez niej agent nie wie, kiedy skończył.**
To jedyna rzecz, bez której reszta nie działa — i jest darmowa.

### 4. Maszyna merguje, człowiek wchodzi dwa razy

Zielony test → review w świeżym kontekście → merge. Czeka na zależności, nie pyta.
Konflikt mechaniczny rozwiązuje sam. **Konflikt w pliku interfejsu → zapisuje,
nie rusza, wraca do pracy, raport na sync.**

---

## Opcjonalne — i pierwsze do odcięcia

| Mechanizm | Koszt | Co daje | Jeśli zabraknie czasu |
|---|---|---|---|
| **Drugi agent na review** | ~2 min | świeży kontekst, nie widzi rozumowania autora | tnij pierwszy |
| **Trzeci agent „złośliwy"** | ~2 min | łapie to, czego dwaj inni nie zauważą | tnij pierwszy |
| **Mechaniczne rozwiązywanie konfliktów** | 0 | maszyna sama | zostaw, bo bez tego pętla staje |

Ostatnie jest jedynym z trzech, którego **nie** tnęlibyśmy. Reszta systemu 2
zakłada, że maszyna wjeżdża bez pytania.

---

## Pliki

| Plik | Co | Linie |
|---|---|---|
| [`1-RESEARCH.md`](1-RESEARCH.md) | System 1: rozbicie tematu, 5 sesji w 60 minut, brainstorm, wybór | 177 |
| [`KAPSULA.md`](KAPSULA.md) | Szablon. W sobotę nadpisujecie go odpowiedziami. | 114 |
| [`2-BUDOWA.md`](2-BUDOWA.md) | System 2: pięć sesji, test, maszynowy merge, czekanie na moduły | 271 |
| [`3-PIESC.md`](3-PIESC.md) | Zegar. Piątek 30 min, sobota godzina po godzinie. | 150 |

![Dwa systemy](diagram-prosty.png)

**Uwaga o objętości:** 811 → 915 linii. Materiał **urósł**, bo maszynowy merge wymaga
napisania reguły czekania i kolejności, których wcześniej nie było — a to jest
jedyna rzecz, która może zatrzymać pętlę w nocy. Wyrzucone przy tej zmianie:
walidacja merge'a przez człowieka, drabinka eskalacji, osobne stany „czeka / pytaj".
Te ostatnie zastąpiła jedna tabela w kapsule.

Pliki `00_`–`09_`, `render/` i `HISTORY.md` to **poprzedni pakiet** — ten sam, który
był w `main`. Zostawiam je, bo [`archiwum/AUDYT.md`](archiwum/AUDYT.md) się do nich
odwołuje i bo są twoją pracą, nie moją. Nie czyta się ich w sobotę.

[`archiwum/`](archiwum/README.md) — wcześniejsze wersje tego materiału i audyt
oryginalnego pakietu. **Nieoperacyjne.**

---

## Czego tu nie ma i dlaczego

| Nie ma | Dlaczego |
|---|---|
| **Harnessa merge** | merge to reguła w pętli agenta, nie osobny program. Żadnej orkiestracji. |
| checklisty | 5 osób w nocy nie odhacza 77 punktów. Ma trzy komendy i zegar. |
| rejestru ryzyk, premortemów | na co dzień zapis, na potem opowieść. |
| statusów walidacji | zastąpiła je jedna zasada: **twierdzenie bez komendy nie istnieje.** |
| zarządzania pamięcią | 2 dni. Nie ma czego zarządzać. |
| budowania czegokolwiek obok OMP | OMP jest runtime. My piszemy pliki i klikamy sync. |
| osobnych „osób" i „ról" | pięć osób i dwa nazwiska. Reszta to funkcja przy okazji. |

---

## Jedno zdanie

> **System 1 w godzinę bada i podsunie trzy opcje, wybieracie na głos, system 1
> zapisuje wybór w jednym pliku, pięć maszyn buduje z niego w swoich katalogach
> i sama wpuszcza na `main` czekając na moduły, a wy wchodzicie dwa razy — na sync
> i na freeze.**
