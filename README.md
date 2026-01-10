# Homebrew Tap for Hot

This is the official Homebrew tap for [Hot](https://hot.dev), a programming language and runtime.

## Installation

```bash
# Add the tap
brew tap hot-dev/hot

# Install Hot
brew install hot
```

Or install directly without adding the tap:

```bash
brew install hot-dev/hot/hot
```

## Updating

```bash
brew update
brew upgrade hot
```

## Uninstalling

```bash
brew uninstall hot
brew untap hot-dev/hot  # Optional: remove the tap
```

## What's Included

The Homebrew formula installs:

- **`hot` binary** → `/opt/homebrew/bin/hot` (Apple Silicon) or `/usr/local/bin/hot` (Intel)
- **Standard library** (`hot-std`) → `/opt/homebrew/share/hot/pkg/hot-std`
- **Database migrations** → `/opt/homebrew/share/hot/db/`
- **Shell completions** for bash, zsh, and fish

## Getting Started

After installation:

```bash
# Create a new project
hot init myproject
cd myproject

# Start development server
hot dev
```

## Other Installation Methods

- **Shell script**: `curl -fsSL https://get.hot.dev/install.sh | sh`
- **Windows**: `irm https://get.hot.dev/install.ps1 | iex`
- **Direct download**: [get.hot.dev](https://hot.dev/download)

## Links

- [Hot Documentation](https://hot.dev/docs)

## License

Hot is licensed under the [Hot Dev Software License Agreement](https://hot.dev/license).
