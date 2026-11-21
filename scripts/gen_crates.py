#!/usr/bin/env python3
"""Cargo.lock'tan Gentoo ebuild CRATES listesi üretir.

Kullanım: gen_crates.py Cargo.lock
Çıktı: her satırda bir adet `ad@sürüm`.
"""

from __future__ import annotations

import sys
import tomllib
from pathlib import Path


def main() -> int:
    if len(sys.argv) != 2:
        print(f"kullanım: {Path(sys.argv[0]).name} Cargo.lock", file=sys.stderr)
        return 2

    path = Path(sys.argv[1])
    try:
        with path.open("rb") as fh:
            data = tomllib.load(fh)
    except (OSError, tomllib.TOMLDecodeError) as exc:
        print(f"Cargo.lock okunamadı: {exc}", file=sys.stderr)
        return 1

    crates: set[tuple[str, str]] = set()
    for package in data.get("package", []):
        name = package.get("name")
        version = package.get("version")
        if not name or not version:
            continue
        if name == "animecix":
            continue
        if not package.get("source", "").startswith("registry+"):
            continue
        crates.add((name, version))

    for name, version in sorted(crates):
        print(f"{name}@{version}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
