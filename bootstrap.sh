#!/usr/bin/env bash
set -e
echo "🚀 Bootstrapping dev environment..."

# 1. Homebrew
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# 2. Packages
brew bundle --file="$(dirname "$0")/Brewfile"

# 3. Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# 4. OMZ plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# 5. Powerlevel10k
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  echo "Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k "$ZSH_CUSTOM/themes/powerlevel10k"
fi

# 6. Symlinks
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

symlink() {
  local src="$DOTFILES_DIR/$1"
  local dst="$2"
  mkdir -p "$(dirname "$dst")"
  ln -sf "$src" "$dst"
  echo "  ✓ $dst"
}

echo "Creating symlinks..."
symlink zsh/.zshrc ~/.zshrc
symlink p10k/.p10k.zsh ~/.p10k.zsh
symlink git/.gitconfig ~/.gitconfig

# 7. AI assistant personal context (append, idempotent)
inject_ai_context() {
  local src="$DOTFILES_DIR/$1"
  local dst="$2"
  local marker="# --- BEGIN DOTFILES PERSONAL CONTEXT ---"
  local end_marker="# --- END DOTFILES PERSONAL CONTEXT ---"

  mkdir -p "$(dirname "$dst")"

  if [ -f "$dst" ] && grep -q "$marker" "$dst"; then
    sed -i "/$marker/,/$end_marker/d" "$dst"
  fi

  {
    echo ""
    echo "$marker"
    cat "$src"
    echo "$end_marker"
  } >> "$dst"

  echo "  ✓ $dst (injected)"
}

echo "Injecting AI personal context..."
inject_ai_context claude/CLAUDE.md ~/.claude/CLAUDE.md
inject_ai_context codex/AGENTS.md ~/AGENTS.md

echo "✅ Done. Restart your terminal."