#!/usr/bin/env bash
#
# py.sh — install Pi (https://pi.dev) coding agent + extensions.
# Prereq: Node >= 18 (npm on PATH). No brew formula exists for pi; npm is the
# officially supported install path.
#
set -euo pipefail

# 1. Pi coding agent (skip if present)
if ! command -v pi >/dev/null 2>&1; then
    npm install -g --ignore-scripts @earendil-works/pi-coding-agent
fi

# npm global bin is not always on PATH (esp. brew node / nvm split) — add it
export PATH="$(npm prefix -g)/bin:$PATH"

command -v pi >/dev/null 2>&1 || {
    echo "ERROR: pi install failed / not on PATH." >&2
    exit 1
}

# 2. extensions
# pi-web-access: web search, content extraction, video understanding
# https://github.com/nicobailon/pi-web-access
pi install npm:pi-web-access

echo
echo "pi installed: $(pi --version 2>/dev/null || echo unknown)"
echo "Run 'pi' to start, then '/login' to authenticate with a provider."
echo
echo "Add npm global bin to PATH permanently (in ~/.zshrc):"
echo "  export PATH=\"\$(npm prefix -g)/bin:\$PATH\""
