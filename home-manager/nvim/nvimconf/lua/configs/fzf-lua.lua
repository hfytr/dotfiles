local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local fzflua = require('fzf-lua')
map('n', '<leader>sf', fzflua.files)
map('n', '<leader>sh', fzflua.helptags)
map('n', '<leader>sg', fzflua.live_grep_native)
map('n', '<leader>sr', fzflua.resume)
map('n', '<leader>sw', fzflua.grep_cword)
map('n', '<leader>sW', fzflua.grep_cWORD)

fzflua.setup({
    'default',
    winopts = { preview = { default = 'bat' } },
    keymap = { fzf = { ['ctrl-q'] = 'select-all+accept' } },
    files = { no_ignore = true },
    grep = { no_ignore = true },
})

map('n', '<leader>ho', function()
    local height = tonumber(vim.api.nvim_command_output('echo &lines'))
    fzflua.fzf_live(
        'hoogle <query> --count ' .. tostring(math.floor(height * 0.85)),
        { prompt = 'Hoogle> ', exec_empty_query = false }
    )
end)
