local opts = { noremap = true, silent = true }

function reload_marks()
    local cwd_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':gs?/?-?')
    local shada_name = '~/.config/nvim/shadas/' .. cwd_name .. '.shada'
    require('projectmarks').setup({ shadafile = shada_name, mappings = false })
    print('Loading shada file at: ' .. shada_name)
end
reload_marks()

local keys = { 'N', 'R', 'T', 'S', 'Q', 'M', 'W', 'L', 'D', 'C' }
for _, key in ipairs(keys) do
    vim.keymap.set('n', '<C-' .. key .. '>', "'" .. key, opts)
end

vim.api.nvim_create_user_command('Zoxide', function(args)
    print('running: zoxide query ' .. args.args)
    local cmd = { 'zoxide', 'query' }
    vim.fn.jobstart(vim.list_extend(cmd, args.fargs), {
        on_stdout = function(job_id, data, event)
            local path = table.concat(data, ''):gsub('\n', '')
            if path ~= '' then
                print('cwd: ' .. path)
                vim.cmd('lchdir' .. path) -- only change cur win dir
                reload_marks()
            end
        end,
        on_stderr = function(job_id, data, event)
            local err_msg = table.concat(data, '\n')
            if err_msg ~= '' then
                print('zoxide error: ' .. err_msg)
            end
        end,
    })
end, { nargs = '+' })
vim.keymap.set('n', 'cd', ':Zoxide ')

-- TABS
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', opts)
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
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'WinEnter' }, {
    command = 'startinsert',
    pattern = 'term://*',
})
vim.api.nvim_create_autocmd('BufLeave', {
    command = 'stopinsert',
    pattern = 'term://*',
})
