vim.keymap.set('i', '<Tab>', function()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    row = row - 1
    local cur_char
    if col == 0 then
        cur_char = ' '
    else
        cur_char = vim.api.nvim_buf_get_text(0, row, col - 1, row, col, {})[1]
    end
    if string.match(cur_char, '%s') then
        return '<Tab>'
    else
        vim.lsp.buf.completion()
    end
end, { expr = true })
