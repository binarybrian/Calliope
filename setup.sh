#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
BACKEND="$ROOT/calliope-backend"
WEB="$ROOT/calliope-web"

echo "============================================"
echo " Calliope first-time setup - idempotent, safe to re-run"
echo "============================================"

if [ ! -d "$BACKEND/.venv" ]; then
    echo "[1/2] Creating venv and installing backend deps..."
    (cd "$BACKEND" && python3 -m venv .venv && .venv/bin/pip install --upgrade pip && .venv/bin/pip install -e ".[dev]")
else
    echo "[1/2] Backend deps already installed - skipping"
fi

if [ ! -d "$WEB/node_modules" ]; then
    echo "[2/2] Installing frontend deps, running npm install..."
    (cd "$WEB" && npm install)
else
    echo "[2/2] Frontend deps already installed - skipping"
fi

echo ""
echo "Setup complete."
echo "Before the first launch, copy calliope_config.example.json to calliope_config.json"
echo "to configure LLM/ComfyUI, or configure them on the in-app Settings page."
