#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
BACKEND="$ROOT/calliope-backend"
WEB="$ROOT/calliope-web"
LOGS="$ROOT/logs"

if [ ! -d "$BACKEND/.venv" ]; then
    echo "[Error] Backend not installed - run ./setup.sh first"
    exit 1
fi
if [ ! -d "$WEB/node_modules" ]; then
    echo "[Error] Frontend not installed - run ./setup.sh first"
    exit 1
fi

mkdir -p "$LOGS"

echo "Starting backend in background...   Log: logs/backend.log"
(cd "$BACKEND" && nohup .venv/bin/python -m calliope.main --host 127.0.0.1 --port 8247 > "$LOGS/backend.log" 2> "$LOGS/backend.err.log" &)
echo "Backend PID -> $!"

echo "Starting frontend in background...   Log: logs/web.log"
(cd "$WEB" && nohup npm run dev > "$LOGS/web.log" 2> "$LOGS/web.err.log" &)
echo "Web npm PID -> $!"

echo ""
echo "Background services started:"
echo "  Backend:  http://127.0.0.1:8247"
echo "  Frontend: http://127.0.0.1:5173"
echo "Run ./stop.sh to stop them."
