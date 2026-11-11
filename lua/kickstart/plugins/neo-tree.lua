-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

vim.pack.add {
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = vim.version.range '*' },
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
}

vim.keymap.set('n', '\\', '<Cmd>Neotree reveal<CR>', { desc = 'NeoTree reveal', silent = true })
vim.keymap.set('n', '<leader>e', '<Cmd>Neotree toggle<CR>', { desc = 'Reveal Neotree', silent = true })

require('neo-tree').setup {
  filesystem = {
    window = {
      mappings = {
        -- Overwriting default space keymapping to be none to free up space bar for toggling
        ['<space>'] = 'none',
        -- ['<leader>e'] = { 'close_window', desc = 'Close Neotree' },
        ['\\'] = { 'close_window', desc = 'Close Neotree' },
        ['l'] = 'open_or_expand',
        ['h'] = 'close_node',
      },
    },
    commands = {
      open_or_expand = function(state)
        local tree = state.tree._link
        local node = state.tree:get_node()
        if not node then return end
        if node.type == 'directory' then
          if not node._is_expanded then require('neo-tree.sources.filesystem.commands').toggle_node(state) end
        else
          require('neo-tree.sources.filesystem.commands').open(state)
        end
      end,
    },
  },
}
