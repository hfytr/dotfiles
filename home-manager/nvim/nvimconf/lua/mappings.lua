local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local eopts = { noremap = true, expr = true, silent = true }

map('n', 'k', "v:count == 0 ? 'gk' : 'k'", eopts)
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", eopts)
map({ 'n', 'v' }, '<PageUp>', function()
    vim.cmd(
        'normal! '
            .. tostring(math.floor(vim.api.nvim_win_get_height(0) / 2))
            .. 'gkzz'
    )
end, opts)
map({ 'n', 'v' }, '<PageDown>', function()
    vim.cmd(
        'normal! '
            .. tostring(math.floor(vim.api.nvim_win_get_height(0) / 2))
            .. 'gjzz'
    )
end, opts)

map('n', 'n', 'nzz', opts)
map('n', 'N', 'Nzz', opts)
map('n', '<Esc>', ':nohl<Esc>', opts)

map('v', '<', '<gv')
map('v', '>', '>gv')
map('n', 'gq', function()
    vim.cmd('normal! gg0VGgq')
end)

map('n', 'U', '<C-r>', opts)

-- un-gq document (kinda)
map('n', '<leader>gq', [[normal! %s/\n\([^\n]\)/ \1/<cr>%s/\n /\n/<cr>]])

-- searches
map('n', '<leader>rg', function()
    local file_patt = vim.fn.input('File pattern: ') 
    if file_patt == '' then
        file_patt = '**/*'
    end
    local search_patt = vim.fn.input('Search pattern: ')
    vim.cmd('silent! grep "' .. search_patt .. '" ' .. file_patt)
    vim.cmd('copen')
    vim.cmd('wincmd p')
end, opts)

map('n', '<leader>f', function()
    local buf = vim.api.nvim_create_buf(false, true)
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        col = (vim.o.columns - width) / 2,
        row = (vim.o.lines - height) / 2,
        style = 'minimal',
        border = vim.o.winborder,
    })
    local out = {}
    local on_exit = vim.fn.termopen('fzf', {
        on_stdout = function(_, data, _)
            for _, line in ipairs(data) do
                if line ~= '' then
                    table.insert(out, line)
                end
            end
        end,
        on_exit = function(_, exit_code, _)
            vim.api.nvim_win_close(win, true)
            vim.api.nvim_buf_delete(buf, { force = true })
            if exit_code == 0 and #out > 0 then
                local pre = out[#out]:gsub('[\r\n]', '')
                local file = vim.fn.fnameescape(pre)
                vim.cmd('edit ' .. file)
                print(out[#out])
            end
        end,
    })
    vim.cmd('startinsert')
end, opts)
