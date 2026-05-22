#!/bin/bash
set -e

echo "🚀 Setting up universal dev environment..."

# ─── uv (fast Python package manager) ────────────────────────────────────────
echo "📦 Installing uv..."
curl -LsSf https://astral.sh/uv/install.sh | sh
export PATH="$HOME/.local/bin:$PATH"

# ─── Python global tools ──────────────────────────────────────────────────────
echo "📦 Installing Python tools..."
pip install --upgrade pip
pip install \
  black \
  isort \
  pylint \
  flake8 \
  httpx \
  requests \
  python-dotenv \
  ipykernel

# ─── Node / npm global tools ──────────────────────────────────────────────────
echo "📦 Installing Node tools..."
npm install -g \
  prettier \
  eslint \
  typescript \
  ts-node \
  nodemon \
  http-server

# ─── Go tools ─────────────────────────────────────────────────────────────────
if command -v go &>/dev/null; then
  echo "📦 Installing Go tools..."
  go install golang.org/x/tools/gopls@latest 2>/dev/null || true
fi

# ─── Git config ───────────────────────────────────────────────────────────────
echo "⚙️  Configuring git..."
git config --global user.name  "darthrevan" 
git config --global user.email "smartsamarth03@gmail.com"
git config --global core.autocrlf input
git config --global pull.rebase false
git config --global init.defaultBranch main
git config --global core.editor "code --wait"

# ─── Shell config ─────────────────────────────────────────────────────────────
BASHRC="$HOME/.bashrc"
if ! grep -q "# samarth-config" "$BASHRC" 2>/dev/null; then
  cat >> "$BASHRC" << 'EOF'

# samarth-config

# fzf (if available)
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Python / uv
export PATH="$HOME/.local/bin:$PATH"
alias pip='python -m pip'

# Go
export PATH="$PATH:/usr/local/go/bin"
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Git aliases
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gl='git log --oneline --graph --decorate'

# Python aliases
alias py='python3'
alias activate='source .venv/bin/activate'
alias mkenv='python3 -m venv .venv && source .venv/bin/activate'
EOF
  echo "✅ Shell config added"
fi

# Auto-install deps if lockfiles exist
[ -f "pyproject.toml" ] || [ -f "requirements.txt" ] && pip install -r requirements.txt 2>/dev/null || true
[ -f "package.json" ] && npm install 2>/dev/null || true
[ -f "go.mod" ] && go mod tidy 2>/dev/null || true

echo ""
echo "✅ Universal dev environment ready!"
