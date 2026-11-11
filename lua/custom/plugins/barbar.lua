vim.pack.add { { src = 'https://github.com/romgrk/barbar.nvim', version = vim.version.range '1.*' } }

vim.keymap.set('n', '<leader>bb', '<Cmd>BufferPick<CR>', { desc = 'Toggle magic (B)uffer picker mode' })
vim.keymap.set('n', '<leader>bc', '<Cmd>BufferClose<CR>', { desc = '(C)lose Current Buffer' })
vim.keymap.set('n', '<leader>bn', '<Cmd>BufferNext<CR>', { desc = 'Go To (N)ext Buffer' })
vim.keymap.set('n', '<leader>bp', '<Cmd>BufferPrevious<CR>', { desc = 'Go To (P)revious Buffer' })

require('barbar').setup {}
