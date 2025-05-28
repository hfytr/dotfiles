local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.diagnostic.config({
    virtual_text = { prefix = '■' },
    update_in_insert = true,
    severity_sort = true,
    float = { source = 'always' },
})
map('n', '<leader>de', function()
    vim.diagnostic.setqflist()
    vim.cmd('wincmd p')
end, opts)
map('n', '<leader>df', vim.diagnostic.open_float, opts)
map('n', '<leader>rn', vim.lsp.buf.rename)
map('n', '<C-h>', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, opts)
map('n', 'gr', function()
    vim.lsp.buf.references()
end, opts)
map('n', 'gd', vim.lsp.buf.definition, opts)
map('n', '<C-o>', '<C-t>', opts)
map('n', '<C-i>', ':silent! tag<cr>', opts)

map('n', 'K', vim.lsp.buf.hover, opts)

local servers = {
    clangd = {
        cmd = { 'clangd' },
        filetypes = { 'c', 'cpp' },
        root = { '.clang-format', 'Makefile', 'CMakeLists.txt', '.git' },
    },
    pyright = {
        cmd = { 'pyright-langserver', '--stdio' },
        filetypes = { 'python' },
        root = { 'pyproject.toml', 'requirements.txt', '.git' },
    },
    rust_analyzer = {
        cmd = { 'rust-analyzer' },
        filetypes = { 'rust' },
        root = { 'Cargo.toml', '.git' },
    },
    lua_ls = {
        cmd = { 'lua-language-server' },
        filetypes = { 'lua' },
        root = { 'stylua.toml', '.git' },
    },
    -- { lsp = 'hls', filetypes = { 'haskell', 'lhaskell', 'cabal' } },
}

for lsp, opts in pairs(servers) do
    vim.lsp.config[lsp] = opts
    vim.lsp.enable({ lsp })
end
