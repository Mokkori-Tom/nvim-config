#!/usr/bin/env bash
# Neovim と周辺ツールを入れて ~/.config/nvim をこのディレクトリに向ける。
# sudo 不要（Linux は ~/.local/bin に、Termux は pkg で入れる）。
set -euo pipefail

HERE=$(cd "$(dirname "$0")" && pwd)
BIN="$HOME/.local/bin"
OPT="$HOME/.local/opt"

have() { command -v "$1" >/dev/null 2>&1; }

# GitHub の最新リリースから、名前が $2 に一致するアセットの URL を返す
asset() {
  curl -fsSL "https://api.github.com/repos/$1/releases/latest" |
    grep -o '"browser_download_url": *"[^"]*"' | cut -d'"' -f4 | grep -E "$2" | head -1
}

install_linux() {
  local arch; arch=$(uname -m)
  local a_nvim a_lg a_ts a_rg a_fd
  case "$arch" in
    x86_64)  a_nvim=linux-x86_64; a_lg=linux_x86_64; a_ts=linux-x64;   a_rg=x86_64-unknown-linux-musl;  a_fd=x86_64-unknown-linux-musl ;;
    aarch64) a_nvim=linux-arm64;  a_lg=linux_arm64;  a_ts=linux-arm64; a_rg=aarch64-unknown-linux-gnu; a_fd=aarch64-unknown-linux-musl ;;
    *) echo "未対応の CPU: $arch" >&2; exit 1 ;;
  esac
  mkdir -p "$BIN" "$OPT"
  tmp=$(mktemp -d); trap 'rm -rf "$tmp"' EXIT

  if ! have nvim; then
    curl -fsSL "$(asset neovim/neovim "nvim-$a_nvim\.tar\.gz$")" | tar xz -C "$OPT"
    ln -sf "$OPT/nvim-$a_nvim/bin/nvim" "$BIN/nvim"
  fi
  have lazygit || curl -fsSL "$(asset jesseduffield/lazygit "_${a_lg}\.tar\.gz$")" | tar xz -C "$BIN" lazygit
  if ! have tree-sitter; then
    curl -fsSL "$(asset tree-sitter/tree-sitter "tree-sitter-$a_ts\.gz$")" | gunzip > "$BIN/tree-sitter"
    chmod +x "$BIN/tree-sitter"
  fi
  if ! have rg; then
    curl -fsSL "$(asset BurntSushi/ripgrep "$a_rg\.tar\.gz$")" | tar xz -C "$tmp"
    cp "$tmp"/ripgrep-*/rg "$BIN/"
  fi
  if ! have fd; then
    curl -fsSL "$(asset sharkdp/fd "$a_fd\.tar\.gz$")" | tar xz -C "$tmp"
    cp "$tmp"/fd-*/fd "$BIN/"
  fi
}

if [ -n "${TERMUX_VERSION:-}" ]; then
  pkg install -y neovim git ripgrep fd lazygit nodejs clang make
  # tree-sitter CLI は Termux では tree-sitter パッケージに入っている（tree-sitter-cli は無い）
  pkg install -y tree-sitter || echo "tree-sitter CLI が入らなかった（構文ハイライトのパーサー導入に必要）" >&2
  pkg install -y unzip
  "$HERE/termux-font.sh"
else
  for c in git curl tar gcc make; do have "$c" || { echo "$c が必要です" >&2; exit 1; }; done
  install_linux
  case ":$PATH:" in *":$BIN:"*) ;; *) echo "※ $BIN を PATH に足してください" >&2; export PATH="$BIN:$PATH" ;; esac
fi

# ~/.config/nvim をこのディレクトリへのリンクにする（既存は退避）
mkdir -p "$HOME/.config"
if [ -e "$HOME/.config/nvim" ] && [ "$(readlink -f "$HOME/.config/nvim")" != "$HERE" ]; then
  mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak.$(date +%Y%m%d%H%M%S)"
fi
ln -sfn "$HERE" "$HOME/.config/nvim"

# SKK 辞書（skk.nvim 用）
JISYO="$HOME/.local/share/nvim/skk/SKK-JISYO.L"
if [ ! -f "$JISYO" ]; then
  mkdir -p "$(dirname "$JISYO")"
  curl -fsSL https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.L -o "$JISYO"
fi

# lazy-lock.json の版でプラグインを揃える
nvim --headless "+Lazy! restore" "+Lazy! install" +qa
echo "完了: nvim を起動してください"
