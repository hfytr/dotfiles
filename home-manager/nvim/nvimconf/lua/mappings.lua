local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local eopts = { noremap = true, expr = true, silent = true }

map('n', 'k', "v:count == 0 ? 'gk' : 'k'", eopts)
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", eopts)
map({ 'n', 'v' }, '<PageUp>', function()
    vim.cmd.normal(
        tostring(math.floor(vim.api.nvim_win_get_height(0) / 2)) .. 'gkzz'
    )
end, opts)
map({ 'n', 'v' }, '<PageDown>', function()
    vim.cmd.normal(
        tostring(math.floor(vim.api.nvim_win_get_height(0) / 2)) .. 'gjzz'
    )
end, opts)

map('n', 'n', 'nzz', opts)
map('n', 'N', 'Nzz', opts)
map('n', '<Esc>', ':nohl<cr>', opts)

map('v', '<', '<gv')
map('v', '>', '>gv')

for left, right in pairs({
    ['('] = ')',
    ['{'] = '}',
    ['['] = ']',
    ["'"] = "'",
    ['"'] = '"',
    ['<'] = '>',
}) do
    map('i', left, left .. right .. '<Left>', opts)
end

map('n', 'U', '<C-r>', opts)

map({ 'n', 'i' }, '<C-z>', '<esc>:wincmd _<cr> :wincmd |<cr>', opts)

map('n', '<C-q>', function()
    for _, win in ipairs(vim.fn.getwininfo()) do
        if win.quickfix == 1 then
            vim.cmd.cclose()
            return
        end
    end
    vim.cmd.copen()
    vim.cmd.wincmd('p')
end, opts)
map('n', '<leader>gr', ':silent! vim ', { noremap = true })
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
    vim.fn.termopen('fzf', {
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
                local pre = out[#out]
                    :gsub('[\r\n]', '')
                    :gsub('\x1b[^A-Za-z]*[A-Za-z]', '')
                local file = vim.fn.fnameescape(pre)
                vim.cmd('edit ' .. file)
            end
        end,
    })
    vim.api.nvim_buf_set_keymap(buf, 'i', '<Esc>', '<Esc>:q', opts)
    vim.cmd('startinsert')
end, opts)

vim.keymap.set('t', '<C-E>', '<C-\\><C-n>', opts)
vim.keymap.set({ 'n', 't', 'i' }, '<C-S-C>', function()
    vim.cmd('tabnew')
end, opts)
vim.keymap.set({ 'n', 't', 'i' }, '<C-S-F>', function()
    vim.cmd('term')
    vim.cmd('startinsert')
end, opts)
vim.keymap.set('n', '|', function()
    vim.cmd('vsplit')
    vim.cmd('enew')
end, opts)
vim.keymap.set('n', '-', function()
    vim.cmd('split')
    vim.cmd('enew')
end, opts)

local keys = { 'N', 'R', 'T', 'S', 'G' }
for i, key in ipairs(keys) do
    vim.keymap.set({ 'n', 't', 'i' }, '<C-S-' .. key .. '>', function()
        vim.cmd(':tabn ' .. i)
        reload_marks()
    end, opts)
end

vim.keymap.set({ 'n', 't', 'i' }, '<C-S-Y>', function()
    vim.cmd('wincmd h')
end, opts)
vim.keymap.set({ 'n', 't', 'i' }, '<C-S-H>', function()
    vim.cmd('wincmd j')
end, opts)
vim.keymap.set({ 'n', 't', 'i' }, '<C-S-A>', function()
    vim.cmd('wincmd k')
end, opts)
vim.keymap.set({ 'n', 't', 'i' }, '<C-S-E>', function()
    vim.cmd('wincmd l')
end, opts)
