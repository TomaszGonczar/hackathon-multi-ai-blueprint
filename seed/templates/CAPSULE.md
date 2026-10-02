# CAPSULE

**Topic:** <!-- verbatim, as announced -->
**Chosen option:** <!-- one name, no discussion -->
**Chosen:** <!-- who, when, out loud -->
**System 2 start:** <!-- when building may begin -->

---

## 1. What we are building

<!-- One-two sentences. As much as can be said without reading the rest.
     It must be falsifiable. If it is not - go back to research. -->



---

## 2. Why this option

<!-- Three sentences. Why THIS one and not the other two.
     Enough so that someone who was not at the brainstorm does not wonder about it. -->

**Rejected:**
- <!-- option + one sentence why not -->
- <!-- option + one sentence why not -->

---

## 3. What we know

<!-- Facts relevant for the BUILD phase. Each with a link. 5-15 points.
     With an hour of research there will be fewer and they will be less certain - let us be aware of that. -->

- <!-- fact --> - source: https://address

---

## 4. What we don't know

<!-- RISKS. With one hour of research this is the most important section.
     System 1 fills it in itself - you have no time, and you know less.
     Someone will surely look at it at night. Better that it be a choice, not a surprise. -->

- <!-- unanswered question -->

---

## 5. Five pieces

<!-- THIS IS WHAT GUARDS AGAINST COLLISIONS AND MERGE ORDER.

     Directories are physically separate: one git worktree per person. Two pieces cannot
     have the same file - if they do, it is not a split, it is the lack of one.

     COLUMN "WAITS FOR" - this is the order of landing on main. The machine reads it
     and DOES NOT ASK. Piece 4 waits for 1 and 2, so 4 will not land until 1 and 2
     are on main. If you do not fill in this column, the machine will stop
     and wait for a human, and that is exactly what we do not want.

     Look: can these five vertices be arranged so that there is NO cycle?
     Cycle = deadlock = the machine waits forever. -->

| # | Directory | Input / output | Does | Does not touch | **Waits for** |
|---|---|---|---|---|---|
| 1 | `w1-.../` | in: <!-- --> / out: <!-- --> | | | - |
| 2 | `w2-.../` | in: <!-- --> / out: <!-- --> | | | - |
| 3 | `w3-.../` | in: <!-- --> / out: <!-- --> | | | 1, 2 |
| 4 | `w4-.../` | in: <!-- --> / out: <!-- --> | | | 1, 2 |
| 5 | `w5-.../` | in: <!-- --> / out: <!-- --> | | | 1, 2, 3, 4 |

**Interface files** - files touched by more than one piece. A conflict
in these files the machine **does not resolve**:

- `<!-- e.g. src/api/types.py -->`

---

## 6. How we check

<!-- ONE COMMAND PER PIECE. Exit 0 = done = the machine may land on main.
     This section must be filled in BEFORE System 2 starts. -->

```bash
# example - you write the real commands
# ONE COMMAND PER PIECE, run from your worktree directory:
cd ~/w1-... && ./check.sh; echo $?
cd ~/w2-... && ./check.sh; echo $?
cd ~/w3-... && ./check.sh; echo $?
cd ~/w4-... && ./check.sh; echo $?
cd ~/w5-... && ./check.sh; echo $?
# 0 = this piece is done
```

**A test that catches nothing is not a test.** Before the start: deliberately break one
piece and check that `check.sh` notices.

---

<!--
FOR SYSTEM 2 - do not edit the above.
  1. Read this whole file. This is everything you need to know.
  2. Make ./check.sh before you write the first line of code.
  3. Work in your directory. Push every 30 min and always before sleep.
  4. Green test → review → TRY TO LAND ON MAIN.
       - your dependencies (column "Waits for") not on main yet → WAIT, go back to work
       - mechanical conflict → resolve it yourself
       - conflict in an interface file → WRITE IT DOWN, do not touch, go back to work, report at sync
       - review reports a correctness gap → fix it, do not land
  5. Do not ask system 1 for advice - everything is here. Something missing?
     Add it to section 4 and carry on.
-->
