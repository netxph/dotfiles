local map = vim.api.nvim_set_keymap

map('n', '<Space>', '', {})
vim.g.mapleader = ' '

options = { noremap = true, silent = true }

map('n', ';', ':', options)

map('n', '<leader>ve', ':e $MYVIMRC<CR>', options)
map('n', '<leader>vs', ':so $MYVIMRC<CR>', options)

map('n', '<leader>p', [[<cmd>lua require('telescope.builtin').find_files({ find_command = { 'rg', '--files', '--hidden', '-g', '!.git' }})<CR>]], options)

map('n', '<leader>gr', [[<cmd>lua require('telescope.builtin').lsp_references()<CR>]], options)
map('n', '<leader>gd', [[<cmd>lua require('telescope.builtin').lsp_definitions()<CR>]], options)

map('n', 'f', [[<cmd>lua require('hop').hint_words()<cr>]], options)