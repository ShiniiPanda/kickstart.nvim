-- TOGGLETERM
--
--
vim.pack.add { { src = 'https://github.com/akinsho/toggleterm.nvim', version = vim.version.range '2.*' } }
require('toggleterm').setup {

  size = function(term)
    if term.direction == 'horizontal' then
      return 15
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.4
    end
  end,
  start_in_insert = false,
}

vim.keymap.set('n', '<leader>tv', '<Cmd>ToggleTerm direction=vertical<CR>', { desc = 'Opens a vertical terminal' })
vim.keymap.set('n', '<leader>th', '<Cmd>ToggleTerm direction=horizontal<CR>', { desc = 'Opens a horizontal terminal' })
vim.keymap.set('n', '<leader>tf', '<Cmd>ToggleTerm direction=float<CR>', { desc = 'Opens a float terminal' })
vim.keymap.set('n', '<leader>tt', '<Cmd>ToggleTerm direction=tab<CR>', { desc = 'Opens a tab terminal' })

-- Implementing custom terminals below;
--
--
-- LAZYGIT INTEGRATION

local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new {
  cmd = 'lazygit',
  count = 99, -- a dedicated id
  direction = 'float',
  hidden = true, -- this doesn't actually make the terminal "hidden" but it hides it from :ToggleTerm list
  float_opts = { border = 'double' },
  close_on_exit = true,
  on_open = function(term)
    vim.cmd 'startinsert!'
    vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<Cmd>close<CR>', { noremap = true, silent = true })
  end,
}
local function _lazygit_toggle() lazygit:toggle() end
vim.keymap.set('n', '<leader>gg', _lazygit_toggle, { desc = 'Toggle Lazygit Terminal' })

-- :ToggleTerm size=40 dir=~/Desktop direction=horizontal name=desktop
