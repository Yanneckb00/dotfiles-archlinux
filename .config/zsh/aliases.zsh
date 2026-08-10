###################
### Zsh Aliases ###
###################

# --- Navigation ---
alias ..='cd ..'
alias ...='cd ../..'
alias lg='lazygit'
alias c='clear'
alias gfl='git fetch --all && git pull'

if command -v lsd >/dev/null; then
  alias ls='lsd'
  alias la='lsd -la'
elif command -v eza >/dev/null; then
  alias ls='eza --icons'
  alias la='eza -la --icons'
fi

# --- Arch ---
alias ua='sudo pacman -Syu && sudo yay -Syu'