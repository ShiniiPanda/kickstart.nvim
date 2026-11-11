local function _open_theme_viewer()
  -- Fetch themes from getcompletion
  local themes = vim.fn.getcompletion('', 'color')
  -- Get the currently set theme.
  local original = vim.g.colors_name

  -- Create buffer, add the lines fetched from themes, and make it unmodifiable
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, themes)
  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden = 'wipe'

  local width, height = 30, math.min(#themes, 20)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = 'minimal',
    border = 'rounded',
    title = ' Themes ',
  })

  -- Enable cursorline for the created window so that I can scroll themes
  vim.wo[win].cursorline = true

  local function preview()
    -- [1] because lua starts arrays from fucking 1
    local selected_theme = themes[vim.api.nvim_win_get_cursor(win)[1]]
    local preview_attempt = pcall(vim.cmd.colorscheme, selected_theme)
    if preview_attempt == false then vim.print 'error' end
  end

  local function close()
    if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end
  end

  local function cancel()
    if original then pcall(vim.cmd.colorscheme, original) end
    close()
  end

  vim.api.nvim_create_autocmd('CursorMoved', { buffer = buf, desc = 'Previews the theme when the cursor moves.', callback = preview })

  vim.keymap.set('n', '<CR>', close, { buffer = buf })
  vim.keymap.set('n', '<Esc>', cancel, { buffer = buf })
  vim.keymap.set('n', 'q', cancel, { buffer = buf })
end

vim.api.nvim_create_user_command('ThemeViewer', _open_theme_viewer, { desc = 'Opens the theme viewer' })
vim.keymap.set('n', '<leader>ut', _open_theme_viewer, { desc = 'Open [T]heme Viewer' })
