local opts = { noremap = true, silent = true }
local eopts = { noremap = true, expr = true, silent = true }

vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", eopts)
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", eopts)
vim.keymap.set({ 'n', 'v' }, '<PageUp>', function()
    vim.cmd.normal(
        tostring(math.floor(vim.api.nvim_win_get_height(0) / 2)) .. 'gkzz'
    )
end, opts)
vim.keymap.set({ 'n', 'v' }, '<PageDown>', function()
    vim.cmd.normal(
        tostring(math.floor(vim.api.nvim_win_get_height(0) / 2)) .. 'gjzz'
    )
end, opts)

vim.keymap.set('n', 'n', 'nzz', opts)
vim.keymap.set('n', 'N', 'Nzz', opts)
vim.keymap.set('n', '<Esc>', ':nohl<cr>', opts)

vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

for left, right in pairs({
    ['('] = { ')', { '*' } },
    ['{'] = { '}', { '*' } },
    ['['] = { ']', { '*' } },
    ['"'] = { '"', { '*' } },
    ["'"] = { "'", { "*.[^'txt''tex']" } },
    ['<'] = { '>', { '*.rs' } },
}) do
    vim.api.nvim_create_autocmd('BufEnter', {
        pattern = right[2],
        callback = function(_)
            vim.keymap.set('i', left, left .. right[1] .. '<Left>', opts)
        end,
    })
end

vim.keymap.set('n', 'U', '<C-r>', opts)

vim.keymap.set({ 'n', 'i' }, '<C-z>', function()
    if vim.w.maximized == nil or vim.w.maximized == false then
        vim.w.maximized = true
        vim.cmd.wincmd('_')
        vim.cmd.wincmd('|')
    else
        vim.w.maximized = false
        vim.cmd.wincmd('=')
    end
end, opts)

vim.keymap.set('n', '<C-q>', function()
    for _, win in ipairs(vim.fn.getwininfo()) do
        if win.quickfix == 1 then
            vim.cmd.cclose()
            return
        end
    end
    vim.cmd.copen()
    vim.cmd.wincmd('p')
end, opts)
vim.keymap.set('n', '<leader>gr', ':silent vim ', { noremap = true })
vim.keymap.set('n', '<leader>f', function()
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
    vim.fn.jobstart({ 'fzf' }, {
        term = true,
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
    vim.cmd('wshada!')
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
