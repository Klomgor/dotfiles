# 🏠 Dotfiles

A minimal, secure dotfiles management system using [chezmoi](https://www.chezmoi.io/).

## 🚀 Overview

This repository contains my personal dotfiles for macOS, managed with chezmoi. It's designed to be:

- **Minimal**: Only essential configuration files, no large caches or binaries
- **Secure**: Sensitive files are properly encrypted
- **Reproducible**: Easy to set up on a new machine
- **Automated**: CI/CD pipeline for security scanning and updates

## ⚙️ What's Included

- Shell configuration (Zsh)
- Git configuration
- Editor settings
- Application configurations (iTerm2, etc.)
- Templates for common configuration files
- Automated security scanning
- Configuration testing

## ⛔ What's Excluded

To keep this repository lean, the following are excluded:

1. **Cache Files**: npm, gem, yarn caches
2. **Large Binaries**: SWT libraries, kubectl binaries
3. **Temporary Files**: Logs, lock files
4. **Regeneratable Content**: TLDR pages, Vagrant boxes
5. **State Files**: Application state, history databases
6. **Database Files**: SQLite databases

## 🛠️ Setup

### Prerequisites

- Git
- [chezmoi](https://www.chezmoi.io/install/)

### Installation

```bash
# Install chezmoi and apply dotfiles
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/USERNAME/dotfiles.git
```

## 🔄 Usage

### Working with Files

```bash
# Add a file to chezmoi
chezmoi add ~/.zshrc

# Edit a file
chezmoi edit ~/.zshrc

# Preview changes before applying
chezmoi diff

# Apply changes to your home directory
chezmoi apply
```

### Syncing Changes

Chezmoi manages files in three locations:

1. **Home directory** (~/): Where you use the files
2. **Source directory** (~/.local/share/chezmoi): Local repository
3. **Remote repository**: GitHub backup

#### Home → Source → Remote (Making Changes)

When you modify files in your home directory:

```bash
# Add changes to source directory
chezmoi add ~/.zshrc

# To automatically commit and push changes
# The chezmoi.yaml.templ already includes:
# git:
#   autoCommit: true
#   autoPush: true

# Or manually:
chezmoi cd
git add .
git commit -m "Update zshrc"
git push
exit
```

#### Remote → Source → Home (Getting Updates)

When the remote repository has changes:

```bash
# Update source from remote and preview changes
chezmoi update --dry-run

# Apply the changes to your home directory
chezmoi update
```

#### Source → Home (Local Changes)

If you directly edit files in the source directory:

```bash
# Preview changes
chezmoi diff

# Apply changes
chezmoi apply
```

## 🔐 Security

- Sensitive files are prefixed with `private_` in the repository
- chezmoi automatically applies appropriate permissions
- Automated security scanning via GitHub Actions:
  - Gitleaks: Checks for hardcoded secrets using pattern matching
  - TruffleHog: Uses entropy analysis to detect potential secrets
- Custom security rules in `.gitleaks.toml` and `.trufflehog.yaml`

## 🤖 Automation

This repository uses GitHub Actions for several automated tasks:

1. **Security Scanning**: Detects secrets and sensitive information
2. **Linting**: Ensures code quality with Super-linter
3. **Configuration Testing**: Validates chezmoi configuration
4. **Automated Updates**: Optionally updates machines on schedule

The automation pipeline runs:

- On every push to main
- On pull requests
- Daily at 7:00 AM UTC
- Manually when triggered

## 🧑‍💻 Major Configurations

### Shell (Zsh)

- Modern prompt with [starship](https://starship.rs/)
- Useful aliases and functions
- Integration with development tools

### Git

- User information and preferences
- Useful aliases
- Global ignore patterns

### Templates

The `dot_templates` directory contains template files that can be used as a starting point for new projects.

## 📋 Maintenance

The `.chezmoiignore` file contains patterns that exclude unnecessary files from being managed by chezmoi. This helps keep the repository clean and focused on essential configuration.
