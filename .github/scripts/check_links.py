#!/usr/bin/env python3
"""Fail if any relative Markdown link or image points at a file that does not exist.

The same check CI used to run inline, kept as a script so it also runs locally:

    python3 .github/scripts/check_links.py
"""
import os
import re
import sys

LINK = re.compile(r"\[([^\]]+)\]\(([^)]+)\)")
SKIP = ("http://", "https://", "#", "mailto:")


def main() -> int:
    root = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
    broken = []
    for dirpath, dirnames, filenames in os.walk(root):
        dirnames[:] = [d for d in dirnames if d not in (".git", "node_modules")]
        for name in sorted(filenames):
            if not name.endswith(".md"):
                continue
            path = os.path.join(dirpath, name)
            with open(path, encoding="utf-8") as fh:
                text = fh.read()
            for _, link in LINK.findall(text):
                if link.startswith(SKIP):
                    continue
                target = os.path.normpath(os.path.join(dirpath, link.split("#")[0]))
                if not os.path.exists(target):
                    broken.append((os.path.relpath(path, root), link))
    if broken:
        print(f"Found {len(broken)} broken links:")
        for path, link in broken:
            print(f"  {path}: {link}")
        return 1
    print("All internal markdown links resolve.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
