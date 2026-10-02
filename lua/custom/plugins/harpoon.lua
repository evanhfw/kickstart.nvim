-- harpoon
-- https://github.com/ThePrimeagen/harpoon

vim.pack.add { { src = 'https://github.com/ThePrimeagen/harpoon', version = 'harpoon2' } }

local harpoon = require 'harpoon'
harpoon:setup {}

vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end, { desc = 'Harpoon: add file' })
vim.keymap.set('n', '<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon: toggle quick menu' })

for i = 1, 4 do
  vim.keymap.set('n', '<leader>' .. i, function() harpoon:list():select(i) end, { desc = 'Harpoon: select file ' .. i })
end
