local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- putting in on_attach doesnt work, idk why
local fzflua = require("fzf-lua")
map("n", "<leader>gr", fzflua.lsp_references, opts)
map("n", "<leader>gs", fzflua.lsp_live_workspace_symbols, opts)
map("n", "<leader>gi", fzflua.lsp_implementations, opts)
map("n", "<leader>ca", fzflua.lsp_code_actions, opts)
map("n", "<leader>rn", vim.lsp.buf.rename)

map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "<C-o>", "<C-t>", opts)
map("n", "<C-i>", ":silent! tag<cr>", opts)

map("n", "K", vim.lsp.buf.hover, opts)
map("n", "<C-k>", vim.lsp.buf.signature_help, opts)

local lspconfig = require("lspconfig")
local servers = {
    { lsp = "clangd", ft = { "c", "cpp" } },
    { lsp = "pyright", ft = { "python" } },
    { lsp = "rust_analyzer", ft = { "rust" } },
    { lsp = "lua_ls", ft = { "lua" } },
}

for _, server in ipairs(servers) do
    lspconfig[server.lsp].setup({
        on_attach = function(_, bufnr) end,
        filetypes = server.ft,
    })
end
