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
| Search | telescope (+ fzf-native, ui-select) |
| LSP | lua_ls, gopls, pyright — auto-installed and enabled via Mason |
| Completion | blink.cmp (rust fuzzy matcher), LuaSnip, friendly-snippets |
| Lint | nvim-lint: markdownlint (markdown), ruff (Python), golangci-lint (Go) |
| Format | conform.nvim — format-on-save disabled, manual with `<leader>f` |
| Editing | mini.ai, mini.surround, nvim-autopairs, nvim-treesitter (auto-installs parsers) |
| Navigation | harpoon2, venv-selector, netrw |

Notes:

- The `ruff` language server is disabled on purpose (see `lua/custom/plugins/lint.lua`) because Python linting runs through nvim-lint instead.
- Format-on-save is off. To enable it per filetype, uncomment the entry in `enabled_filetypes` in `init.lua` (Section 7).

## Keymaps

Leader is `<Space>`. Press `<Space>` and pause to see everything via which-key.

### Search (telescope)

| Key | Action |
| --- | --- |
| `<leader><space>` | Find files (root dir) |
| `<leader>,` | Switch buffer |
| `<leader>/` | Grep (root dir) |

### Files, windows, navigation

| Key | Action |
| --- | --- |
| `<leader>e` | Toggle netrw sidebar (Lexplore) |
| `<leader>E` | Open netrw in current dir (Explore) |
| `<leader>f` | Format buffer |
| `<leader>q` | Diagnostics to quickfix list |
| `<leader>vs` | Select Python virtualenv |
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | Move between windows |

### Harpoon

| Key | Action |
| --- | --- |
| `<leader>a` | Add current file |
| `<C-e>` | Toggle quick menu |
| `<leader>1`–`<leader>4` | Jump to marked file |

### Git (gitsigns, on buffers in a repo)

| Key | Action |
| --- | --- |
| `<leader>hs` / `<leader>hr` | Stage / reset hunk |
| `<leader>hS` / `<leader>hR` | Stage / reset whole buffer |
| `<leader>hp` / `<leader>hi` | Preview hunk (float / inline) |
| `<leader>hb` | Blame line |
| `<leader>hd` / `<leader>hD` | Diff against index / last commit |
| `<leader>hq` / `<leader>hQ` | Hunks to quickfix (file / repo) |
| `]c` / `[c` | Next / previous hunk |
| `ih` | Select hunk (text object) |
| `<leader>tb` / `<leader>tw` | Toggle blame line / word diff |

### LSP (when a server attaches)

| Key | Action |
| --- | --- |
| `grn` | Rename symbol |
| `gra` | Code action |
| `grr` / `gri` / `grd` / `grt` / `grD` | References / implementation / definition / type definition / declaration |
| `gO` / `gW` | Document / workspace symbols |
| `K` | Hover documentation |
| `<leader>th` | Toggle inlay hints (when supported) |
| `[d` / `]d` | Previous / next diagnostic |
| `[D` / `]D` | First / last diagnostic |

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
| `<C-n>` / `<C-p>` | Next / previous item |
| `<C-space>` | Open menu or docs |
| `<C-e>` | Hide menu |
| `<C-k>` | Toggle signature help |
| `<Tab>` / `<S-Tab>` | Jump through snippet placeholders |

## Maintenance

- Plugins install on startup. Inspect and update them with:
  - `:lua vim.pack.update(nil, { offline = true })` — inspect plugin state and pending updates
  - `:lua vim.pack.update()` — fetch updates (`:write` applies, `:quit` cancels)
- Manage tools and LSP servers with `:Mason` (press `g?` for help) or `:MasonToolsInstallSync` to install everything listed in `init.lua`.
- Run `:checkhealth` after changing LSP or tool settings.

## Credits

Based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) by TJ DeVries and contributors.
