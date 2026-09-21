#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
BACKEND="$ROOT/calliope-backend"
WEB="$ROOT/calliope-web"

if [ ! -d "$BACKEND/.venv" ]; then
    echo "[Error] Backend not installed - run ./setup.sh first"
    exit 1
fi
if [ ! -d "$WEB/node_modules" ]; then
    echo "[Error] Frontend not installed - run ./setup.sh first"
    exit 1
fi

echo "Opening two windows"
echo "  Backend:  http://127.0.0.1:8247"
echo "  Frontend: http://127.0.0.1:5173"
echo "Close a window to stop that service"

gnome-terminal --title="Calliope Backend" --working-directory="$BACKEND" -- bash -c ".venv/bin/python -m calliope.main --host 127.0.0.1 --port 8247; exec bash"
gnome-terminal --title="Calliope Web" --working-directory="$WEB" -- bash -c "npm run dev; exec bash"
