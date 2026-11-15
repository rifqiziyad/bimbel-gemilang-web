#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
FIGCRAFT_BIN="/Applications/FigCraft.app/Contents/MacOS/FigCraft"
DESIGN_FILE="$ROOT_DIR/design/bimbel-gemilang.figcraft"
PORT="${FIGCRAFT_CONTROL_PORT:-47800}"

if [ ! -x "$FIGCRAFT_BIN" ]; then
  echo "Error: FigCraft.app tidak ditemukan di $FIGCRAFT_BIN" >&2
  exit 1
fi

if lsof -iTCP:"$PORT" -sTCP:LISTEN >/dev/null 2>&1; then
  echo "FigCraft Live Sync sudah aktif di port $PORT."
  exit 0
fi

if pgrep -x "FigCraft" >/dev/null 2>&1; then
  echo "FigCraft.app sedang berjalan tanpa mode --control $PORT."
  echo "Silakan tutup FigCraft terlebih dahulu (Cmd+Q), lalu jalankan ulang script ini."
  exit 1
fi

echo "Membuka FigCraft Live Sync (port $PORT) dengan $DESIGN_FILE ..."
nohup "$FIGCRAFT_BIN" \
  --control "$PORT" \
  --automation-read-root "$ROOT_DIR" \
  --automation-write-root "$ROOT_DIR" \
  "$DESIGN_FILE" >/dev/null 2>&1 &

echo "FigCraft terbuka di background. Setelah siap, refresh/restart MCP 'figcraft' di Antigravity."
