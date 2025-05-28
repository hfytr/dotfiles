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

vim.api.nvim_create_autocmd('TermClose', {
    pattern = 'term://*yazi',
    callback = function()
        vim.api.nvim_input('<CR>')
    end,
})
vim.api.nvim_create_autocmd('BufWritePost', { command = 'mkview' })
vim.api.nvim_create_autocmd('BufReadPost', { command = 'silent! loadview' })
vim.api.nvim_create_autocmd('VimResized', { command = 'wincmd =' })

vim.api.nvim_create_autocmd({ 'BufWinEnter', 'WinEnter' }, {
    command = 'startinsert',
    pattern = 'term://*',
})
vim.api.nvim_create_autocmd('BufLeave', {
    command = 'stopinsert',
    pattern = 'term://*',
})

local shiftwidths = { haskell = 2, nix = 2 }
local default_shiftwidth = 4
vim.api.nvim_create_autocmd('BufEnter', {
    callback = function()
        vim.bo.shiftwidth = shiftwidths[vim.bo.filetype] or default_shiftwidth
        if vim.bo.filetype == 'rust' then
            vim.o.colorcolumn = '101'
        else
            vim.o.colorcolumn = '81'
        end
    end,
})

local fmt_cmds = {
    c = 'clang_format',
    cpp = 'clang_format',
    haskell = 'ormolu',
    lua = 'stylua -',
    python = 'ruff format -',
    rust = 'rustfmt --emit=stdout',
}
local function update_formatting()
    vim.o.formatprg = fmt_cmds[vim.o.filetype] or ''
end
vim.api.nvim_create_autocmd('BufEnter', { callback = update_formatting })
local function custom_format()
    local diagnostic_opts = { severity = vim.diagnostic.severity.ERROR }
    local errors = next(vim.diagnostic.get(0, diagnostic_opts)) ~= nil
    local no_lsp = next(vim.lsp.get_clients()) == nil
    if vim.o.formatprg == '' or errors or no_lsp then
        return
    end
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd.normal('gg0VGgq')
    vim.api.nvim_win_set_cursor(0, pos)
end
vim.api.nvim_create_autocmd('BufWritePre', { callback = custom_format })

vim.g.compiling_latex = false
local function build_latex()
    if not vim.g.compiling_latex then
        return
    end
    local cmd = { 'pdflatex', '-output-directory', 'latex_out' }
    table.insert(cmd, vim.fn.expand('%'))
    local out_dir = vim.cmd.pwd() .. '/latex_out/'
    local ok, err, code = os.rename(out_dir, out_dir)
    if not ok then
        if code == 13 then
            print('Out directory latex_out exists but is not writable.')
            return
        end
        vim.system({ 'mkdir', out_dir }):wait()
    end
    vim.system(cmd)
    print('building')
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
