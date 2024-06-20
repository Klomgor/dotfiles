# Attention

This is my very first attempt at creating a repository. I don't have any background in IT and I am still learning and experimenting with different configurations. Therefore, this repo will more likely have bugs, at least for now. If you're interested in using more robust and well-maintained dotfiles, I recommend checking out the resources section below.

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

The following titles are placeholders for now and will be updated as I progress.

## Installation

### Prerequisites

Install Apple's Command Line Tools, which are prerequisites for Git and Homebrew.

```zsh
xcode-select --install
```

Clone repo into new hidden directory (Use SSH (if set up)).

```zsh
git clone git@github.com:klomgor/dotfiles.git ~/.dotfiles
```

or use HTTPS and switch remotes later.

```zsh
git clone https://github.com/klomgor/dotfiles.git ~/.dotfiles
```

### Package Manager

```zsh
-c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew bundle --file ~/.dotfiles/Brewfile
```

### Dotfiles Manager

```zsh
export GITHUB_USERNAME="your_github_username"
zsh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
```

### Terminal, Application Icons, and Fonts

To display icons in terminal or applications Fonts, I'm using [Nerd-Fonts](https://www.nerdfonts.com). I'm currently using the **Hack Nerd Font Mono** in terminal applications, and **Hack Nerd Font** in applications.

### Docker Image

```zsh
docker build -t klomgor/dotfiles .
docker run --rm -it --entrypoint zsh klomgor/dotfiles
```

## Resources

- [CristopherBiscard](https://github.com/ChristopherBiscardi/dotfiles)
- [GeekMasher](https://github.com/GeekMasher/.dotfiles)
- [andrew8088](https://github.com/andrew8088/dotfiles)
- [christianlempa](https://github.com/christianlempa/dotfiles)
- [geerlingguy](https://github.com/geerlingguy/dotfiles)
- [logandonley](https://github.com/logandonley/dotfiles)
- [marcogreiveldinger](https://github.com/marcogreiveldinger/.dotfiles)
- [bitprophet](https://github.com/bitprophet/dotfiles)
