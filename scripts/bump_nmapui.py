#!/usr/bin/env python3
"""Point Formula/nmapui.rb at a TM-NmapUI tag or commit.

Downloads the source archive, records its sha256, and regenerates the
Python wheel resources from the archive's packaging/homebrew/requirements.lock
(macOS arm64 / universal wheels for CPython 3.12, else the sdist).

  scripts/bump_nmapui.py --ref v2026.11.2 --version 2026.11.2
"""
import argparse
import hashlib
import io
import json
import re
import tarfile
import urllib.request
from pathlib import Path

FORMULA = Path(__file__).resolve().parents[1] / "Formula" / "nmapui.rb"
REPO = "https://github.com/techmore/TM-NmapUI"
BUILD_TOOLS = [("setuptools", "80.9.0"), ("wheel", "0.45.1")]
BEGIN = "  # BEGIN generated resources (scripts/bump_nmapui.py)\n"
END = "  # END generated resources\n"


def fetch(url):
    with urllib.request.urlopen(url, timeout=60) as response:
        return response.read()


def score(entry):
    name = entry["filename"]
    mac = "macosx" in name and ("arm64" in name or "universal2" in name)
    if entry["packagetype"] == "sdist":
        return 1
    if "cp312" in name and mac:
        return 5
    if ("abi3" in name or "py3-none" in name) and mac:
        return 4
    if name.endswith("-none-any.whl"):
        return 3
    return 0


def resources(lock_text):
    pins = re.findall(r"^([A-Za-z0-9_.-]+)==([^\s\;]+)", lock_text, re.M) + BUILD_TOOLS
    blocks = []
    for name, version in pins:
        data = json.loads(fetch(f"https://pypi.org/pypi/{name}/{version}/json"))
        best = max(data["urls"], key=score)
        if score(best) == 0:
            raise SystemExit(f"no macOS arm64 wheel or sdist for {name}=={version}")
        blocks.append(f'  resource "{name.lower()}" do\n    url "{best["url"]}"\n'
                      f'    sha256 "{best["digests"]["sha256"]}"\n  end\n')
    return "\n".join(blocks)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--ref", required=True, help="tag (refs/tags/...) or 40-char commit")
    parser.add_argument("--version", required=True)
    args = parser.parse_args()
    ref = args.ref
    url = f"{REPO}/archive/{ref}.tar.gz" if re.fullmatch(r"[0-9a-f]{40}", ref) else f"{REPO}/archive/refs/tags/{ref}.tar.gz"
    archive = fetch(url)
    sha256 = hashlib.sha256(archive).hexdigest()
    with tarfile.open(fileobj=io.BytesIO(archive)) as tar:
        member = next(m for m in tar.getmembers() if m.name.endswith("packaging/homebrew/requirements.lock"))
        lock_text = tar.extractfile(member).read().decode()

    text = FORMULA.read_text()
    text = re.sub(r'^  url "[^"]+"$', f'  url "{url}"', text, count=1, flags=re.M)
    # Homebrew reads the version from a tag URL and flags an explicit one as
    # redundant; a commit URL needs it.
    text = re.sub(r'^  version "[^"]+"\n', "", text, count=1, flags=re.M)
    if "/archive/refs/tags/" not in url:
        text = re.sub(r'^(  url "[^"]+"\n)', lambda m: m.group(1) + f'  version "{args.version}"\n', text, count=1, flags=re.M)
    text = re.sub(r'^  sha256 "[0-9a-f]{64}"$', f'  sha256 "{sha256}"', text, count=1, flags=re.M)
    start, end = text.index(BEGIN) + len(BEGIN), text.index(END)
    text = text[:start] + resources(lock_text) + text[end:]
    FORMULA.write_text(text)
    print(f"nmapui {args.version}: {url} {sha256}")


if __name__ == "__main__":
    main()
