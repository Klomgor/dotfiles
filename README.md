# Dotfiles

## Goal

The goal is to have a centralized location for all my configurations, in order to have a completely automated-OS Agnostic-setup for new machines. This is far from reality right now, and my main focus will be on macOS as it is my current daily driver.
I will be using [chezmoi](https://www.chezmoi.io/) to manage my dotfiles. The next step would be using [Ansible](https://www.ansible.com/) to automate the installation of all the necessary software.

## Thought Process

As a non-IT person, I used to utilize time machine backups to setup new machines. However, this prevented me from having a clean install if I wanted to start fresh, no backup plan if my time machine backup failed, and no way to have a consistent setup across different Operating Systems if I wanted to switch from macOS to Linux or Windows.

## Solution

After doing some research I found different ways people usually manage their system configurations.

- Install everything manually, which is very painful, time-consuming, and error-prone.
- Use [git](https://www.atlassian.com/git/tutorials/dotfiles) to manage dotfiles, still with a lot of manual work.
- Use [git with symlinks](https://github.com/eieioxyz/Beyond-Dotfiles-in-100-Seconds) for a cleaner setup.
- Use a Symlink Farm Manager like [GNU Stow](https://www.gnu.org/software/stow/).
- Use a dotfile manager like [yadm](https://yadm.io/), or [chezmoi](https://www.chezmoi.io/).

## Decision

Although yadm seems to be easier to use, I decided to go with chezmoi as it seems to be more powerful, flexible, and supports more platforms.

## Workflow

### Installation

For different Operating Systems, Installation is straight forward, as detailed in [chezmoi](https://www.chezmoi.io/install)'s Installation instructions.

The following steps are for macOS.

Apple's Command Line Tools, Git, and Homebrew are required to get chezmoi installed and work properly.

For Apple's Command Line Tools, run the following command in the terminal to install them.

```zsh
xcode-select --install
```

Git gets installed automatically with Apple's Command Line Tools. To check if it's installed, run the following command.

```zsh
git --version
```

If you don’t have it installed already, it will prompt you to install it.

For Homebrew, run the following command.

```zsh
-c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Then install chezmoi using Homebrew, with the follwing command.

```zsh
brew install chezmoi
```

### Setup

For detailed instructions on how chezmoi works, please refer to the [User Guide](https://www.chezmoi.io/user-guide/command-overview/).

1. Initialize chezmoi by running the following command in your home directory.

    ```zsh
    chezmoi init
    ```

    This will create a local repository at ```zsh ~/.local/share/chezmoi``` and a configuration file at ```zsh ~/.config/chezmoi/chezmoi.toml```.

2. Start adding your dotfiles from the home directory to the chezmoi local repository.

    You can add specific files ```zsh chezmoi add $FILE```, specific folders ```zsh chezmoi add ~/$FOLDER```  or everything in the home directory ```zsh chezmoi add .```.

    If you choose to add everything in the home directory, or to automate the process (as explained later), make sure that you add a .chezmoiignore file in the local repo to exclude files or folders that you don't want to manage with chezmoi.

3. Create a new repository on GitHub, and push your local repository to it.

    ```zsh
    chezmoi cd
    git remote add origin https://github.com/$GITHUB_USERNAME/dotfiles.git
    git push -u origin main
    exit
    ```

    Make sure to add the files that contain sensitive information to the .gitignore file.

4. Automate the process by using Github Actions, Chezmoi, and Gitleaks.

    Add the following to chezmoi configuration file to automatically sync your dotfiles with the remote repository.

    ```toml
    [git]
        autoCommit = true
        autoPush = true
    ```

    Add the following to your GitHub repository workflow to automatically run Gitleaks on every push. This will automatically scan your repository for secrets and prevent them from being pushed to the remote repository.

    ```yml
    name: Automatic Update Submodules
    on:
    push:
        branches:
        - main
    workflow_dispatch:
    schedule:
        - cron: '0 7 * * *'
    pull_request:
        types:
        - opened
        - synchronize
    jobs:
    scan:
        name: gitleaks
        runs-on: ubuntu-latest
        steps:
        - uses: actions/checkout@v3
            with:
            fetch-depth: 0
        - uses: gitleaks/gitleaks-action@v2
            env:
            GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    ```

5. Use chezmoi password manager integration an added layer of security and a more optimized workflow (to be added later).

### Usage

To apply the configurations to a new machine, run the following command.

```zsh
chezmoi init --apply --verbose https://github.com/$GITHUB_USERNAME/dotfiles.git
```

You can also integrate this step with an Ansible playbook to automate the installation of all the necessary software (to be added in a different repo).

## Configuration Files and Scripts

### .gitconfig

The `.gitconfig` file contains the configuration settings for Git. It includes user information, such as name and email, and other settings like the template directory and Git LFS configuration.

Example:

```ini
[user]
    name = Your Name
    email = your.email@example.com
[init]
    templateDir = /usr/local/share/git-core/templates
[filter "lfs"]
    required = true
    clean = git-lfs clean -- %f
    smudge = git-lfs smudge -- %f
    process = git-lfs filter-process
```

### .github/workflows/update.yml

The `.github/workflows/update.yml` file defines the GitHub Actions workflow for automatically updating the repository. It includes steps for checking out the repository, running Gitleaks for secret scanning, and other automated tasks.

Example:

```yaml
name: Automatic Update
on:
  push:
    branches:
      - main
  workflow_dispatch:
  schedule:
    - cron: '0 7 * * *'
  pull_request:
    types:
      - opened
      - synchronize
jobs:
  update:
    name: Update
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3
  scan:
    name: gitleaks
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
        with:
          fetch-depth: 0
      - uses: gitleaks/gitleaks-action@v2
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

### dot_zshrc

The `dot_zshrc` file contains the configuration settings for the Zsh shell. It includes aliases, environment variables, and other settings to customize the shell environment.

Example:

```zsh
export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=1

test -e /Users/osama/.iterm2_shell_integration.zsh && source /Users/osama/.iterm2_shell_integration.zsh || true

eval "$(gh copilot alias -- zsh)"

eval "$(starship init zsh)"

eval "$(zoxide init zsh)"

source <(fzf --zsh)

eval $(thefuck --alias)

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source ~/.tldr.complete

alias zshconfig="code ~/.zshrc"
alias sourcezsh="source ~/.zshrc"
alias ls="eza"
alias ll="eza -l"
alias la="eza -la"
alias cat="bat"
alias grep="rg"
alias find="fzf"
alias cd="z"
alias cdc="z -"
alias lzd='lazydocker'
```

## Examples and Use Cases

### Example 1: Setting Up a New Machine

To set up a new machine with the same configurations, follow these steps:

1. Install Apple's Command Line Tools, Git, and Homebrew.
2. Install chezmoi using Homebrew.
3. Initialize chezmoi and apply the configurations from the remote repository.

```zsh
xcode-select --install
brew install chezmoi
chezmoi init --apply --verbose https://github.com/$GITHUB_USERNAME/dotfiles.git
```

### Example 2: Adding a New Dotfile

To add a new dotfile to the chezmoi repository, follow these steps:

1. Add the dotfile to the chezmoi local repository.

```zsh
chezmoi add ~/.new_dotfile
```

2. Commit and push the changes to the remote repository.

```zsh
chezmoi cd
git add .
git commit -m "Add new dotfile"
git push
exit
```

## Troubleshooting Common Issues

### Issue 1: Git Not Found

If you encounter an error indicating that Git is not found, ensure that Apple's Command Line Tools are installed. Run the following command to install them:

```zsh
xcode-select --install
```

### Issue 2: Permission Denied

If you encounter a "Permission Denied" error, ensure that you have the necessary permissions to access the files and directories. You may need to use `sudo` for certain commands.

### Issue 3: Gitleaks Scan Failure

If the Gitleaks scan fails, check the scan results for any detected secrets. Remove the detected secrets from the repository and update the `.gitignore` file to prevent them from being committed in the future.

```zsh
chezmoi cd
# Remove detected secrets
git add .
git commit -m "Remove detected secrets"
git push
exit
```
