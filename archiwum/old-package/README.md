# old-package — oryginalny pakiet stojący wcześniej w katalogu głównym

**Zamrożone. Nieoperacyjne. Nie czytasz tego w sobotę.**

To jest pakiet, który leżał w katalogu głównym repo przed refaktorem na dwa systemy.
Zdjęty z roota 2026-10-02, żeby nie mieszał się z tym, co operacyjne — **nie
usunięty**, bo jest dowodem i cudzą pracą.

## Co tu jest

| Plik | Co to było |
|---|---|
| `00_DELIVERABLE_CONTRACT.md` | kontrakt na dokumenty dostarczane |
| `01_DISCOVERY_CLOSURE.md` | rejestr pytań domkniętych |
| `02_REUSE_LEDGER.md` | prowenancja cudzej pracy, 15 pozycji |
| `03_ARCHITECTURE_BLUEPRINT.md` | architektura z **obserwatorem** i Mission Package |
| `04_DEVELOPMENT_PLAN.md` | plan wykonania |
| `05_IMPLEMENTATION_CHECKLIST.md` | checklista 77 punktów |
| `06_ARCHITECTURE.mmd` | źródło diagramu (`render/06_ARCHITECTURE.png`, `.svg`) |
| `07_FAILURE_AND_REHEARSAL_PLAN.md` | plan awaryjny i prób generalnych |
| `08_PORTFOLIO_BRIEF.md` | portfolio autora |
| `09_REVIEW_RECORD.md` | rejestr przeglądów tego pakietu |
| `HISTORY.md` | log zmian repo |
| `render/` | wyrenderowany diagram architektury |

## Dlaczego nie jest operacyjny

Opisuje architekturę, którą refaktor **świadomie odwrócił**:

| Ten pakiet mówi | Korpus w katalogu głównym mówi |
|---|---|
| `Observer mode — read-only` monitoruje odchylenia | obserwator **usunięty** → review w świeżym kontekście |
| `Mission Package vN` jako artefakt graniczny | jeden przewód: `../KAPSULA.md` |
| „Human authority — **no AI merge, ever**" | **maszyna merguje**; człowiek wchodzi 2× (sync, freeze) |

Dlatego `README.md`, `AGENTS.md` i `KAPSULA.md` mówią wprost: **nie czytasz
`archiwum/`.** Jeśli natkniesz się na ten katalog jako agent — to nie są twoje
instrukcje.

## Jedyne, po co tu zaglądać

[`../AUDYT.md`](../AUDYT.md) — audyt tego pakietu. §3.1 opisuje żywą sprzeczność
w oryginale: rejestr przeglądu (`09_REVIEW_RECORD.md`, F-05) deklaruje ją jako
naprawioną, a naprawiona jest w dwóch z czterech miejsc. To zostaje jako przykład,
nie jako zadanie.

Linki wewnątrz tych plików są względne wobec siebie — działają, bo cały zestaw
przeniesiono razem.