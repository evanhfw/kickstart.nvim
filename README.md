# Neovim Config

My personal Neovim configuration, based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).
It uses the built-in `vim.pack` plugin manager (no lazy.nvim).

- Everything lives in a single, fully commented `init.lua`.
- Personal additions go in `lua/custom/plugins/` (auto-loaded), keeping `init.lua` easy to diff against upstream.
- Work happens on the `personal-config` branch; `master` mirrors upstream kickstart.

## Requirements

- Neovim 0.12+ (latest stable)
- `git`, `make`, `unzip`, a C compiler
- `ripgrep`, `fd`, `tree-sitter` CLI, a Nerd Font
- `lazygit` (optional, for `<leader>gg`/`gG`)
- `gh` (optional, only for the GitHub keymaps `<leader>gi/gI/gp/gP`)
- `go` (Go development) and Node.js/`npm` (for pyright) on `PATH`

## Setup on a new machine

```sh
git clone git@github.com:evanhfw/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
nvim   # plugins install automatically on first launch
```

Then install the Mason-managed tools inside Neovim:

```vim
:MasonToolsInstallSync
```

## What's included

| Area | Details |
| --- | --- |
| UI | tokyonight-night, mini.statusline, which-key, indent-blankline, todo-comments, gitsigns |
| Search | snacks.picker — LazyVim's keymaps (`<leader><leader>`/`ff`/`fg`/`sg`/`sd`/`sw`/`ss` …) |
| LSP | lua_ls, gopls, pyright — auto-installed and enabled via Mason; LazyVim keymaps (`gd`/`gr`/`gI`/`gy`, `<leader>c*`) |
| Git | gitsigns hunks (`<leader>gh*`), lazygit (`<leader>gg`/`gG`), snacks.picker git log/blame/diff/status (`<leader>g*`) |
| Completion | blink.cmp (rust fuzzy matcher), LuaSnip, friendly-snippets |
| Lint | nvim-lint: markdownlint (markdown), ruff (Python), golangci-lint (Go) |
| Format | conform.nvim — format-on-save disabled, manual with `<leader>cf` |
| Editing | mini.ai, mini.surround, nvim-autopairs, nvim-treesitter (auto-installs parsers) |
| Navigation | harpoon2, venv-selector, snacks.explorer |

Notes:

- The `ruff` language server is disabled on purpose (see `lua/custom/plugins/lint.lua`) because Python linting runs through nvim-lint instead.
- Format-on-save is off. To enable it per filetype, uncomment the entry in `enabled_filetypes` in `init.lua` (Section 8, *Formatting*).

## Keymaps

Leader is `<Space>`. Press `<Space>` and pause to see everything via which-key.

### Search (snacks.picker, LazyVim keymaps)

| Key | Action |
| --- | --- |
| `<leader><leader>` / `<leader><space>` | Find files (root dir) |
| `<leader>ff` / `<leader>fF` | Find files (root dir / cwd) |
| `<leader>fg` / `<leader>fr` | Git files / recent |
| `<leader>,` / `<leader>fb` | Switch buffer |
| `<leader>/` / `<leader>sg` / `<leader>sG` | Grep (root dir / root dir / cwd) |
| `<leader>sw` / `<leader>sW` | Grep word or selection (root dir / cwd) |
| `<leader>sd` / `<leader>sD` | Diagnostics / buffer diagnostics |
| `<leader>ss` / `<leader>sS` | LSP symbols / workspace symbols (when an LSP attaches) |
| `<leader>sh` `sk` `sm` `sq` `su` … | Help, keymaps, marks, quickfix, undo, … |
| `<leader>n` | Notification history |

### Files, windows, navigation

| Key | Action |
| --- | --- |
| `<leader>e` | Explorer at project root (snacks explorer) |
| `<leader>E` | Explorer at cwd |
| `<leader>cf` | Format buffer |
| `<leader>q` | Diagnostics to quickfix list |
| `<leader>vs` | Select Python virtualenv |
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | Move between windows |

### Harpoon

| Key | Action |
| --- | --- |
| `<leader>H` | Add current file |
| `<leader>h` | Toggle quick menu |
| `<leader>1`–`<leader>9` | Jump to marked file |

### Git (gitsigns, on buffers in a repo)

| Key | Action |
| --- | --- |
| `<leader>ghs` / `<leader>ghr` | Stage / reset hunk |
| `<leader>ghS` / `<leader>ghR` | Stage / reset whole buffer |
| `<leader>ghu` | Undo stage hunk |
| `<leader>ghp` | Preview hunk inline |
| `<leader>ghb` / `<leader>ghB` | Blame line / buffer |
| `<leader>ghd` / `<leader>ghD` | Diff this / diff this against `~` |
| `]h` / `[h` | Next / previous hunk |
| `]H` / `[H` | First / last hunk |
| `ih` | Select hunk (text object) |
| `<leader>gg` / `<leader>gG` | Lazygit (root dir / cwd) |

### Git (repo-wide, snacks.picker)

These mirror LazyVim's `<leader>g` group. All of them shell out to the `git`
binary — only the GitHub entries need the `gh` CLI.

| Key | Action |
| --- | --- |
| `<leader>gs` / `<leader>gS` | Status / stash |
| `<leader>gd` / `<leader>gD` | Diff hunks / diff against `origin` |
| `<leader>gl` / `<leader>gL` | Log (root dir / cwd) |
| `<leader>gf` / `<leader>gb` | Current file history / blame line |
| `<leader>gB` / `<leader>gY` | Browse in browser (open / copy URL) |
| `<leader>gi` / `<leader>gI` | GitHub issues (open / all) — needs `gh` |
| `<leader>gp` / `<leader>gP` | GitHub PRs (open / all) — needs `gh` |

### LSP (when a server attaches)

Keymaps follow LazyVim. Note that `gr` is a direct mapping to References
(`nowait`), so Neovim's built-in `grn`/`gra` are shadowed — rename and code
action live in the `<leader>c` group instead, exactly as in LazyVim.

| Key | Action |
| --- | --- |
| `gd` / `gD` | Goto definition / declaration (picker) |
| `gr` | References (picker, `nowait`) |
| `gI` / `gy` | Goto implementation / type definition (picker) |
| `gai` / `gao` | Incoming / outgoing calls (picker) |
| `K` / `gK` | Hover documentation / signature help |
| `<C-k>` | Signature help (insert mode) |
| `]]` / `[[` | Next / previous reference (`snacks.words`) |
| `<leader>cr` / `<leader>cR` | Rename symbol / rename file |
| `<leader>ca` | Code action |
| `<leader>cl` / `<leader>cd` / `<leader>cm` | LSP info / line diagnostics / Mason |
| `<leader>ss` / `<leader>sS` | LSP symbols / workspace symbols |
| `<leader>th` | Toggle inlay hints (when supported) |
| `[d` / `]d` | Previous / next diagnostic |
| `[D` / `]D` | First / last diagnostic |

`gi` is left at Neovim's built-in behaviour (jump to the last insert position);
LazyVim uses `gI` for implementation.

### Editing

| Key | Action |
| --- | --- |
| `va)` `ci'` `yiiq` … | mini.ai text objects |
| `sa` / `sd` / `sr` | Add / delete / replace surrounding |
| `gc` / `gcc` | Toggle comment |
| `]n` / `[n`, `an` / `in` | Treesitter incremental selection |

### Completion (insert mode, blink.cmp)

| Key | Action |
| --- | --- |
| `<C-y>` | Accept completion |
| `<C-j>` / `<C-k>` | Next / previous item |
| `<C-n>` / `<C-p>` | Next / previous item (preset default) |
| `<Up>` / `<Down>` | Next / previous item (preset default) |
| `<C-space>` | Open menu or docs |
| `<C-e>` | Hide menu |
| `<C-s>` | Signature help (Neovim 0.11+ built-in) |
| `<Tab>` / `<S-Tab>` | Jump through snippet placeholders |

`<C-j>`/`<C-k>` are customised on top of the `default` preset. Both are free in
insert mode (`<C-j>` duplicates `<CR>`, `<C-k>` only starts a digraph), and the
`fallback` command restores that built-in behaviour whenever the menu is closed.
This takes `<C-k>` away from blink's signature help, which Neovim 0.11+ already
binds to `<C-s>` in insert mode; `gK` in normal mode works too, and
`signature.enabled` auto-shows it while typing arguments.
`<CR>` is left to nvim-autopairs (newline when the menu is closed).

> **Note:** `<C-s>` requires `stty -ixon`, otherwise the terminal treats it as
> XOFF and freezes output. This config sets it in `~/.config/zsh/.zshrc`; on
> another machine add `stty -ixon` to your shell rc.

## Maintenance

- Plugins install on startup. Inspect and update them with:
  - `:lua vim.pack.update(nil, { offline = true })` — inspect plugin state and pending updates
  - `:lua vim.pack.update()` — fetch updates (`:write` applies, `:quit` cancels)
- Manage tools and LSP servers with `:Mason` (press `g?` for help) or `:MasonToolsInstallSync` to install everything listed in `init.lua`.
- Run `:checkhealth` after changing LSP or tool settings.

## Credits

Based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) by TJ DeVries and contributors.
