-- mini.files
-- https://github.com/nvim-mini/mini.nvim/blob/main/readme.md#minifiles

local MiniFiles = require 'mini.files'
MiniFiles.setup {}

vim.keymap.set('n', '<leader>e', function() MiniFiles.open() end, { desc = 'Open file [E]xplorer' })
