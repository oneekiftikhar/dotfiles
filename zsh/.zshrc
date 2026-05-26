# ─────────────────────────────────────────────
# POWERLEVEL10K — must stay at top
# ─────────────────────────────────────────────
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ─────────────────────────────────────────────
# OH MY ZSH
# ─────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# ─────────────────────────────────────────────
# PATH
# ─────────────────────────────────────────────
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# ─────────────────────────────────────────────
# NODE — switched from nvm to fnm (faster)
# ─────────────────────────────────────────────
eval "$(fnm env --use-on-cd)"

# ─────────────────────────────────────────────
# TOOLS
# ─────────────────────────────────────────────
eval "$(zoxide init zsh)"
source <(fzf --zsh)

# ─────────────────────────────────────────────
# SECRETS — never committed to git
# ─────────────────────────────────────────────
[[ -f ~/.secrets ]] && source ~/.secrets

# ─────────────────────────────────────────────
# ALIASES — modern replacements
# ─────────────────────────────────────────────
alias ls='eza --icons'
alias ll='eza -la --icons --git'
alias lt='eza --tree --icons -L 2'
alias cat='bat'
alias grep='rg'
alias find='fd'
alias cd='z'

# ─────────────────────────────────────────────
# ALIASES — git shortcuts
# ─────────────────────────────────────────────
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'

# ─────────────────────────────────────────────
# FUNCTIONS
# ─────────────────────────────────────────────

# Create a dir and cd into it
mkcd() { mkdir -p "$1" && cd "$1" }

# Kill whatever is running on a given port
killport() { lsof -ti tcp:"$1" | xargs kill -9 }

# Print PATH one entry per line
path() { echo $PATH | tr ':' '\n' }

# ─────────────────────────────────────────────
# POWERLEVEL10K CONFIG
# ─────────────────────────────────────────────
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ─────────────────────────────────────────────
# FZF
# ─────────────────────────────────────────────
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh