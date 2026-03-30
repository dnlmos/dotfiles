eval "$(/opt/homebrew/bin/brew shellenv)"

# Starship
if [[ "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select" || \
      "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select-wrapped" ]]; then
    zle -N zle-keymap-select "";
fi

eval "$(starship init zsh)"

# Activate syntax highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Disable underline
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

# Eza
alias l="eza -l --icons --git -a"
alias lt="eza --tree --level=2 --long --icons --git"
alias ltree="eza --tree --level=2  --icons --git"

# Activate autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# Activate fzf
source <(fzf --zsh)

export PATH="$PATH:$HOME/.lmstudio/bin"
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR="nvim"
# editor has vim environment variable, so vim mode in zsh is enabled
# this disables it (emacs)
bindkey -e 
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
# Created by `pipx` on 2026-01-22 14:10:11
export PATH="$PATH:$HOME/.local/bin"
