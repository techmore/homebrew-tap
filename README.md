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
