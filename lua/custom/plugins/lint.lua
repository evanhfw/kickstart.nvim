-- lint
-- https://github.com/mfussenegger/nvim-lint
-- Extra linters on top of the kickstart defaults (markdown)

local lint = require 'lint'

lint.linters_by_ft.python = { 'ruff' }
lint.linters_by_ft.go = { 'golangcilint' }

-- mason-lspconfig auto-enables the `ruff` LSP because the ruff CLI is installed.
-- Linting is handled by nvim-lint above, so disable it to avoid duplicate diagnostics.
vim.lsp.enable('ruff', false)
