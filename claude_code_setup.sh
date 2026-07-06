#!/usr/bin/env bash
#
# claude_code_setup.sh — install Claude Code + agentmemory.
# Local-only: embeddings on-device, compression via local Ollama. No PHI leaves machine.
# Prereq: Node >= 20. For compression run once: ollama pull qwen2.5-coder:7b
#
set -euo pipefail

# 1. Claude Code (skip if present)
command -v claude >/dev/null 2>&1 || curl -fsSL https://claude.ai/install.sh | bash

# 2. agentmemory + on-device embeddings (no API key, nothing leaves machine)
npm install -g @agentmemory/agentmemory @xenova/transformers
# npm global bin is not always on PATH (esp. brew node / nvm split) — add it
export PATH="$(npm prefix -g)/bin:$PATH"

# 3. point compression at local Ollama
mkdir -p ~/.agentmemory
cat > ~/.agentmemory/.env <<'EOF'
EMBEDDING_PROVIDER=local
OPENAI_API_KEY=ollama
OPENAI_BASE_URL=http://localhost:11434/v1
OPENAI_MODEL=qwen2.5-coder:7b
EOF

# 4. wire into Claude Code + verify
agentmemory connect claude-code --with-hooks
agentmemory doctor

echo
echo "Add npm global bin to PATH permanently (in ~/.zshrc):"
echo "  export PATH=\"\$(npm prefix -g)/bin:\$PATH\""
