local telescope = require("telescope")

telescope.setup()

-- Mappings
vim.keymap.set('n', '<leader>ff', function() return require('telescope.builtin').find_files() end)
vim.keymap.set('n', '<leader>fg', function() return require('telescope.builtin').live_grep() end)
vim.keymap.set('n', '<leader>fb', function() return require('telescope.builtin').buffers() end)
vim.keymap.set('n', '<leader>fh', function() return require('telescope.builtin').help_tags() end)
