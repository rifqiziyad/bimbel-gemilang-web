#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
FIGCRAFT_BIN="/Applications/FigCraft.app/Contents/MacOS/FigCraft"
DESIGN_FILE="$ROOT_DIR/design/bimbel-gemilang.figcraft"
PORT="${FIGCRAFT_CONTROL_PORT:-47800}"

RESTART=false
if [ "${1:-}" = "--restart" ]; then
  RESTART=true
fi

if [ ! -x "$FIGCRAFT_BIN" ]; then
  echo "Error: FigCraft.app tidak ditemukan di $FIGCRAFT_BIN" >&2
  exit 1
fi

if lsof -iTCP:"$PORT" -sTCP:LISTEN >/dev/null 2>&1; then
  if [ "$RESTART" = true ]; then
    echo "Merestart FigCraft Live Sync di port $PORT..."
    osascript -e 'tell application "FigCraft" to quit' >/dev/null 2>&1 || true
    for _ in $(seq 1 20); do
      pgrep -x "FigCraft" >/dev/null 2>&1 || break
      sleep 0.25
    done
  else
    echo "FigCraft Live Sync sudah aktif di port $PORT."
    open -a FigCraft "$DESIGN_FILE"
    exit 0
  fi
fi

if pgrep -x "FigCraft" >/dev/null 2>&1; then
  if [ "$RESTART" = true ]; then
    echo "Menutup FigCraft.app yang berjalan tanpa mode --control $PORT..."
    osascript -e 'tell application "FigCraft" to quit' >/dev/null 2>&1 || true
    for _ in $(seq 1 20); do
      pgrep -x "FigCraft" >/dev/null 2>&1 || break
      sleep 0.25
    done
  else
    echo "FigCraft.app sedang berjalan tanpa mode --control $PORT."
    echo "Jalankan dengan --restart atau tutup FigCraft terlebih dahulu (Cmd+Q), lalu jalankan ulang script ini."
    exit 1
  fi
fi

echo "Membuka FigCraft Live Sync (port $PORT) dengan $DESIGN_FILE ..."
nohup "$FIGCRAFT_BIN" \
  --control "$PORT" \
  --automation-read-root "$ROOT_DIR" \
  --automation-write-root "$ROOT_DIR" \
  "$DESIGN_FILE" >/dev/null 2>&1 &

for _ in $(seq 1 40); do
  if lsof -iTCP:"$PORT" -sTCP:LISTEN >/dev/null 2>&1; then
    open -a FigCraft
    echo "FigCraft Live Sync siap di port $PORT."
    exit 0
  fi
  sleep 0.25
done

echo "FigCraft terbuka di background, namun port $PORT belum merespons. Cek jendela FigCraft lalu refresh MCP 'figcraft' di Antigravity."
