local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.diagnostic.config({
    virtual_text = { prefix = '■' },
    severity_sort = true,
    float = { source = 'always' },
})
map('n', '<leader>de', function()
    vim.diagnostic.setqflist()
    vim.cmd('wincmd p')
end, opts)
map('n', '<leader>df', vim.diagnostic.open_float, opts)
map('n', '<leader>rn', vim.lsp.buf.rename)
map('n', '<C-i>', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, opts)
map('n', 'gr', function()
    vim.lsp.buf.references()
    vim.cmd('wincmd p')
end, opts)
map('n', 'gs', function()
    vim.lsp.buf.document_symbol()
    vim.cmd('wincmd p')
end, opts)
map('n', 'gi', function()
    vim.lsp.buf.implementation()
    vim.cmd('wincmd p')
end, opts)
map('n', 'gd', vim.lsp.buf.definition, opts)
map('n', '<C-o>', '<C-t>', opts)
map('n', '<C-i>', ':silent! tag<cr>', opts)

map('n', 'K', vim.lsp.buf.hover, opts)
map('n', '<C-k>', vim.lsp.buf.signature_help, opts)

local servers = {
    {
        lsp = 'clangd',
        cmd = { 'clangd' },
        ft = { 'c', 'cpp' },
        root = { '.clang-format', 'Makefile', 'CMakeLists.txt', '.git' },
    },
    {
        lsp = 'pyright',
        cmd = { 'pyright-langserver', '--stdio' },
        ft = { 'python' },
        root = { 'pyproject.toml', 'requirements.txt', '.git' },
    },
    {
        lsp = 'rust_analyzer',
        cmd = { 'rust-analyzer' },
        ft = { 'rust' },
        root = { 'Cargo.toml', '.git' },
    },
    {
        lsp = 'lua_ls',
        cmd = { 'lua-language-server' },
        ft = { 'lua' },
        root = { 'stylua.toml', '.git' },
    },
    -- { lsp = 'hls', ft = { 'haskell', 'lhaskell', 'cabal' } },
}

for _, server in ipairs(servers) do
    vim.lsp.config[server.lsp] = {
        cmd = server.cmd,
        filetypes = server.ft,
        root_markers = server.root,
    }
    vim.lsp.enable({ server.lsp })
end
