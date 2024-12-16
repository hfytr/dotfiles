require('conform').setup({
    formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'black', 'isort' },
        cpp = { 'clang_format' },
        rust = { 'rustfmt' },
        markdown = { 'deno_fmt' },
        haskell = { 'fourmolu' },
    },
    -- format_after_save = { lsp_format = "fallback" },
    format_after_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
        end
        return { lsp_format = 'fallback' }
    end,
    format = {
        latexindent = {
            inherit = false,
            command = 'latexindent.pl',
            args = {
                '-s',
                '-m',
                '-g=/dev/null',
                '-l="latexindent.yaml"',
                '$FILENAME',
                '-o',
                '$FILENAME',
            },
        },
    },
})

vim.api.nvim_create_user_command('FmtToggle', function(args)
    if args.bang then
        vim.b.disable_autoformat = not vim.b.disable_autoformat
    else
        vim.g.disable_autoformat = not vim.b.disable_autoformat
    end
end, {
    desc = 'Toggle conform.nvim autoformat after save',
    bang = true,
})
