local highlight_group =
    vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

vim.api.nvim_create_autocmd('QuickFixCmdPost', { command = 'copen' })

vim.api.nvim_create_autocmd('TermOpen', {
    callback = function()
        vim.wo.number = false
        vim.wo.relativenumber = true
    end,
})
vim.api.nvim_create_autocmd('WinEnter', {
    callback = function()
        if vim.bo.buftype ~= 'terminal' then
            vim.wo.number = true
            vim.wo.relativenumber = true
        end
    end,
})
vim.api.nvim_create_autocmd('BufWritePost', { command = 'mkview' })
vim.api.nvim_create_autocmd('BufReadPost', { command = 'silent! loadview' })
vim.api.nvim_create_autocmd('VimResized', {
    callback = function()
        if vim.w.maximized then
            vim.cmd.wincmd('_')
            vim.cmd.wincmd('|')
        else
            vim.cmd.wincmd('=')
        end
    end
})

local shiftwidths = { haskell = 2, nix = 2 }
local colorcolumns = { rust = '101', haskell = '', julia = '' }
local default_shiftwidth = 4
local fmt_cmds = {
    c = 'clang_format',
    cpp = 'clang_format',
    haskell = 'fourmolu --stdin-input-file .',
    lua = 'stylua -',
    python = 'ruff format -',
    rust = 'rustfmt --emit=stdout --edition 2024',
}
local function update_ft_vars()
    local ft = vim.bo.filetype
    vim.o.formatprg = fmt_cmds[ft] or ''
    vim.bo.shiftwidth = shiftwidths[ft] or default_shiftwidth
    vim.o.colorcolumn = colorcolumns[ft] or default_colorcolumn
end
vim.api.nvim_create_autocmd('BufEnter', { callback = update_ft_vars })

local function custom_format()
    local diagnostic_opts = { severity = vim.diagnostic.severity.ERROR }
    local errors = next(vim.diagnostic.get(0, diagnostic_opts)) ~= nil
    local no_lsp = next(vim.lsp.get_clients()) == nil
    if vim.o.formatprg == '' or errors or no_lsp then
        return
    end
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd.normal('ggVGgq')
    vim.api.nvim_win_set_cursor(0, pos)
    vim.cmd.normal('zz')
end
-- vim.api.nvim_create_autocmd('BufWritePost', { callback = custom_format })

vim.g.compiling_latex = false
vim.g.zathura_opened = false

local function build_latex()
    if not vim.g.compiling_latex then
        return
    end
    local filename = vim.fn.expand('%')
    local out_dir = 'latex_out'
    local cwd = vim.fn.getcwd()
    local out_dir_path = cwd .. '/' .. out_dir
    local ok, err, code = os.rename(out_dir_path, out_dir_path)
    if not ok then
        if code == 13 then
            print('Out directory latex_out exists but is not writable.')
            return
        end
        vim.fn.mkdir(out_dir, 'p')
    end
    
    local cmd = { 'pdflatex', '-interaction=nonstopmode', '-output-directory', out_dir, filename }
    local compiled_pdf = out_dir .. '/' .. vim.fn.expand('%:t:r') .. '.pdf'
    local pdlatex_on_exit = function(info)
        if not vim.g.zathura_opened then
            vim.g.zathura_opened = true
            local on_exit = function()
                vim.g.zathura_opened = not vim.g.zathura_opened
            end
            vim.system({ 'zathura', compiled_pdf }, { cwd = cwd }, on_exit)
        end
    end
    
    vim.system(cmd, { cwd = cwd }, pdflatex_on_exit)
end

vim.keymap.set('n', '<leader>lt', function()
    vim.g.compiling_latex = not vim.g.compiling_latex
end, { silent = true, noremap = true })

vim.api.nvim_create_autocmd('BufWritePost', {
    callback = function()
        build_latex()
    end,
    pattern = '*.tex',
})
