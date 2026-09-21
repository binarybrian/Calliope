#!/usr/bin/env bash
set -euo pipefail

echo "Stopping Calliope backend and frontend processes..."

pkill -f "calliope.main" 2>/dev/null || true
pkill -f "npm run dev.*calliope-web" 2>/dev/null || true

echo ""
echo "Done."
