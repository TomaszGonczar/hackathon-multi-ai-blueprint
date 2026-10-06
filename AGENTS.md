# AGENTS.md - working on this repository

This repository is a hackathon playbook (Markdown) plus a small shell kit in `seed/`. If you are a
coding agent working on it, these rules are for you.

1. **`seed/templates/AGENTS.md` and `seed/templates/CAPSULE.md` are templates for another
   repository** - the hackathon solution repo that `seed/bootstrap.sh` creates. Here they are
   content to edit, not instructions to follow.
2. **`archive/` is frozen** - the v1 package and its audit. Do not edit it. **`docs/pre-event-review/`
   is a dated record** - fix its links if a move breaks them, never its content.
3. **Never run `seed/bootstrap.sh` against the real `$HOME`** unless asked: it creates
   `~/hackathon-solution` and five worktrees there. Give it a throwaway one,
   `HOME="$(mktemp -d)" bash seed/bootstrap.sh`.
4. **Before you commit, run what CI runs:**

   ```bash
   python3 .github/scripts/check_links.py
   shellcheck seed/bootstrap.sh seed/verify.sh seed/templates/check.sh.example
   SANDBOX="$(mktemp -d)"; HOME="$SANDBOX" bash seed/bootstrap.sh && HOME="$SANDBOX" bash seed/verify.sh
   ```

5. **A check that cannot fail checks nothing.** When you change `bootstrap.sh`, `verify.sh` or
   `check.sh.example`, keep the must-fail cases in `.github/workflows/ci.yml` able to go red, and add
   one for every new guarantee.
