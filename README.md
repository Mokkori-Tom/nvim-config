# nvim-config

日本語で書く人向けの Neovim 設定。Linux と Termux（Android）で同じように使える。

- 日本語入力は [skk.nvim](https://github.com/nabehan/skk.nvim)（Lua だけで動く SKK）
- Space を押すと続きのキーが出る（which-key）ので、覚えていなくても使える
- 導入は sudo 不要

## 入れかた

```sh
git clone https://github.com/Mokkori-Tom/nvim-config ~/nvim-config
~/nvim-config/install.sh
```

`install.sh` がすること:

- Linux（x86_64 / aarch64）: nvim・ripgrep・fd・lazygit・tree-sitter を `~/.local/bin` へ（入っていれば飛ばす）
- Termux: `pkg` で同じものを入れ、表示フォントを PlemolJP Console NF にする
- `~/.config/nvim` をこのディレクトリへのリンクにする（既存は `nvim.bak.日時` に退避）
- SKK 辞書（SKK-JISYO.L）とプラグインを入れる

アイコンには Nerd Font 入りのフォントが要る。Termux から SSH で使うだけなら、Termux で `termux-font.sh` だけ実行すればよい。

Termux と SSH 先（コピー用のコマンドが無いとき）では、ヤンクした内容を OSC 52 で端末のクリップボードへ送る。他のアプリからの貼り付けは端末の長押しメニューで。

## よく使うキー

Leader は Space。

| キー | 動作 |
|---|---|
| `-` / `<leader>e` | ファイラ（Oil。一覧を編集して `:w` で反映） |
| `<leader>ff` / `<leader>sf` | ファイル検索 |
| `<leader>sg` | 全文検索 |
| `<leader>rr` | プロジェクト全体の検索・置換 |
| `gd` / `gr` / `K` | 定義へ / 参照一覧 / 説明（LSP） |
| `Ctrl+\` | 端末を開閉 |
| `<leader>lg` / `Ctrl+g` | lazygit |
| `<leader>?` | このバッファのキー一覧 |
| `jk` | 挿入モードを抜ける |
| `Tab` / `Shift+Tab` | 補完の候補を選ぶ（`Enter` で確定） |

### 日本語入力（SKK）

| キー | 動作 |
|---|---|
| `Ctrl+j` | ひらがな ⇔ 英数（▽▼ の間は確定） |
| `Ctrl+k` | カタカナ ⇔ 英数（ひらがなを経ずにカタカナから打てる。▽▼ の間は確定） |
| `l` / `q` | 英数 / カタカナ |
| 大文字で打つ → `Space` | 漢字変換（`Ctrl+j` か `Enter` で確定） |
| `Esc` | 確定して挿入モードを抜ける（英数に戻る） |

数字と記号は半角（`ー。、「」` も `-.,[]` のまま。長音の ー は `z-` で入れる。全角英数モードの `L` は外してある）。

## ライセンス

この設定は MIT。導入時に取ってくる SKK 辞書（GPL）と PlemolJP（SIL OFL）はこのリポジトリに含まず、それぞれのライセンスに従う。

構成は [kamiyama-fol/dotfiles](https://github.com/kamiyama-fol/dotfiles) の Neovim 設定を参考にした。
