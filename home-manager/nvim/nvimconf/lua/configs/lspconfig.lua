local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- putting in on_attach doesnt work, idk why
local fzflua = require("fzf-lua")

map("n", "<leader>ca", fzflua.lsp_code_actions, opts)
map("n", "<leader>rn", vim.lsp.buf.rename)

map("n", "gr", fzflua.lsp_references, opts)
map("n", "gs", fzflua.lsp_live_workspace_symbols, opts)
map("n", "gi", fzflua.lsp_implementations, opts)
map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "<C-o>", "<C-t>", opts)
map("n", "<C-i>", ":silent! tag<cr>", opts)

map("n", "K", vim.lsp.buf.hover, opts)
map("n", "<C-k>", vim.lsp.buf.signature_help, opts)

local lspconfig = require("lspconfig")
local capabilities = require('blink.cmp').get_lsp_capabilities()
local servers = {
    { lsp = "clangd", ft = { "c", "cpp" } },
    { lsp = "pyright", ft = { "python" } },
    { lsp = "rust_analyzer", ft = { "rust" } },
    { lsp = "lua_ls", ft = { "lua" } },
    { lsp = "ts_ls", ft = { "typescript" } },
    { lsp = "hls", ft = { "haskell", "lhaskell", "cabal" } },
}

local border = {
    {"╭", "FloatBorder"},
    {"─", "FloatBorder"},
    {"╮", "FloatBorder"},
    {"│", "FloatBorder"},
    {"╯", "FloatBorder"},
    {"─", "FloatBorder"},
    {"╰", "FloatBorder"},
    {"│", "FloatBorder"},
}

local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
}

for _, server in ipairs(servers) do
    lspconfig[server.lsp].setup({
        on_attach = function(_, bufnr) end,
        filetypes = server.ft,
        handlers = handlers,
        capabilities = capabilities,
    })
end
