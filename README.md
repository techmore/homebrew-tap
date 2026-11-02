# homebrew-tap
Homebrew formulas for techmore projects

## Emporia Energy Monitor

On Apple Silicon Macs running macOS 13 or newer:

```sh
brew install techmore/tap/energy-monitor
brew services start techmore/tap/energy-monitor
```

The formula builds the menu app locally and installs its pinned Python dependencies
from the release's Apple Silicon wheelhouse. Xcode Command Line Tools are required.
Settings and SQLite history are kept in `$(brew --prefix)/var/energy-monitor`.

## NmapUI

Network scanner web UI for Nmap, on Apple Silicon Macs:

```sh
brew install techmore/tap/nmapui
brew services start techmore/tap/nmapui   # http://127.0.0.1:9000, runs as your user
```

The formula installs a pinned TM-NmapUI release and its hash-locked Python
dependencies from checksummed wheels; nothing runs as root. The first scan
triggers macOS's Local Network prompt; choose Allow. Privileged scans (SYN, OS,
ARP) are optional: see `brew info nmapui` for the one-time setup that installs
a validating helper and a sudoers rule for that helper only.

Releases: the `Bump nmapui` workflow (daily, or run it manually with a tag)
opens a PR with the new archive checksum and regenerated wheel resources
(`scripts/bump_nmapui.py`). Pull requests opened by that workflow do not start
CI automatically; run `brew install --build-from-source` and `brew test` before
merging.
