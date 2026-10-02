-- venv-selector
-- https://github.com/linux-cultist/venv-selector.nvim

vim.pack.add { 'https://github.com/linux-cultist/venv-selector.nvim' }

require('venv-selector').setup {}

vim.keymap.set('n', '<leader>vs', '<cmd>VenvSelect<cr>', { desc = '[S]elect Python virtualenv' })
