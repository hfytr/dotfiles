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

local function reload_marks()
    local cwd_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':gs?/?-?')
    local shadafile = '~/.config/nvim/shadas/' .. cwd_name .. '.shada'
    vim.go.shadafile = vim.fn.findfile(shadafile, '.;')
    vim.cmd('rshada!')
    print('Loading shada file at: ' .. shadafile)
end
reload_marks()

vim.api.nvim_create_user_command('MakeShada', function(args)
    local shadafile = '~/.config/nvim/shadas/' .. cwd_name .. '.shada'
    file.create(shadafile)
end, { nargs = 0 })

vim.api.nvim_create_user_command('Zoxide', function(args)
    print('running: zoxide query ' .. args.args)
    local cmd = { 'zoxide', 'query' }
    vim.fn.jobstart(vim.list_extend(cmd, args.fargs), {
        on_stdout = function(job_id, data, event)
            local path = table.concat(data, ''):gsub('\n', '')
            if path ~= '' then
                print('cwd: ' .. path)
                vim.cmd('lchdir' .. path)
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
