local opts = { noremap = true, silent = true }

local keys = { 'N', 'R', 'T', 'S', 'G' }
for _, key in ipairs(keys) do
    vim.keymap.set('n', '<C-' .. key .. '>', "'" .. key, opts)
end

vim.api.nvim_create_user_command('Marks', function(args)
    local msg = ''
    for _, key in ipairs(keys) do
        local mark = vim.api.nvim_get_mark(key, {})
        if mark[4] ~= '' then
            if msg ~= '' then
                msg = msg .. '\n'
            end
            msg = string.format('%s%s: %s:%d', msg, key, mark[4], mark[1])
        end
    end
    print(msg)
end, { nargs = 0 })

local SHADA_PATH = vim.fn.expand('$HOME/.config/nvim/shadas/')
function reload_marks()
    local cwd_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':gs?/?-?')
    vim.go.shadafile = SHADA_PATH .. cwd_name .. '.shada'
    if vim.fn.filereadable(vim.go.shadafile) then
        vim.cmd('rshada!')
        print('Loading shada file at: ' .. vim.go.shadafile)
    end
end
vim.api.nvim_create_autocmd('DirChanged', { callback = reload_marks })

local keys = { 'N', 'R', 'T', 'S', 'G' }
for i, key in ipairs(keys) do
    vim.keymap.set({ 'n', 't', 'i' }, '<C-S-' .. key .. '>', function()
        vim.cmd('wshada!')
        vim.cmd(':tabn ' .. i)
        reload_marks()
    end, opts)
end

vim.api.nvim_create_user_command('MakeShada', function(args)
    local cwd_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':gs?/?-?')
    local file = assert(io.open(SHADA_PATH .. cwd_name .. '.shada', 'w'))
    file:close()
end, { nargs = 0 })

vim.api.nvim_create_user_command('Zoxide', function(args)
    local cmd = { 'zoxide', 'query' }
    vim.fn.jobstart(vim.list_extend(cmd, args.fargs), {
        on_stdout = function(job_id, data, event)
            local path = table.concat(data, ''):gsub('\n', '')
            if path ~= '' then
                print('cwd: ' .. path)
                vim.cmd('lchdir' .. path)
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

reload_marks()
