# My dotfiles

> Personal configuration files and scripts to set up a development environment from scratch.

---

## Setup instructions

This repository uses [`GNU stow`](https://www.gnu.org/software/stow/) to manage dotfile symlinks cleanly and modularly.

### 1. Clone the repository

```bash
git clone https://github.com/dnlmos/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### 2. Stow the dotfiles
```bash
stow .
```

This will create symbolic links from each file / directory in dotfiles (e.g., `.config`, `.zshrc`) into your `$HOME` directory
