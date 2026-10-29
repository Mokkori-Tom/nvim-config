#!/usr/bin/env bash
# Termux の表示フォントを PlemolJP Console NF（日本語＋Nerd Font アイコン入り）にする。
# 既存の ~/.termux/font.ttf は font.ttf.bak に退避する。
set -euo pipefail
VER=v3.1.0
FONT="$HOME/.termux/font.ttf"
tmp=$(mktemp -d); trap 'rm -rf "$tmp"' EXIT
curl -fsSL -o "$tmp/f.zip" "https://github.com/yuru7/PlemolJP/releases/download/$VER/PlemolJP_NF_$VER.zip"
unzip -q -j "$tmp/f.zip" "PlemolJP_NF_$VER/PlemolJPConsole_NF/PlemolJPConsoleNF-Regular.ttf" -d "$tmp"
mkdir -p "$HOME/.termux"
if [ -f "$FONT" ] && [ ! -f "$FONT.bak" ] && ! cmp -s "$FONT" "$tmp/PlemolJPConsoleNF-Regular.ttf"; then
  mv "$FONT" "$FONT.bak"
fi
cp "$tmp/PlemolJPConsoleNF-Regular.ttf" "$FONT"
command -v termux-reload-settings >/dev/null && termux-reload-settings
echo "フォントを入れました: $FONT"
