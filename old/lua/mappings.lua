local map = vim.api.nvim_set_keymap

map('n', '<Space>', '', {})
vim.g.mapleader = ' '

options = { noremap = true, silent = true }

map('n', ';', ':', options)

map('n', '<leader>ve', ':e $MYVIMRC<CR>', options)
map('n', '<leader>vs', ':so $MYVIMRC<CR>', options)

map('n', '<leader>p', [[<cmd>lua require('telescope.builtin').find_files({ find_command = { 'rg', '--files', '--hidden', '-g', '!.git' }})<CR>]], options)
map('n', '<leader>fg', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], options)
map('n', '<leader>fh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], options)
map('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], options)
map('n', '<leader>ft', [[<cmd>TodoTelescope<CR>]], options)
map('n', '<leader>e', [[<cmd>Neotree toggle<CR>]], options)
map('n', '<leader>o', [[<cmd>Neotree focus<CR>]], options)

map('n', 'f', [[<cmd>lua require('hop').hint_words()<cr>]], options)
