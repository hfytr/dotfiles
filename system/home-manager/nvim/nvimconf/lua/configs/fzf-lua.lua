local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local fzflua = require("fzf-lua")
map("n", "<leader>sf", fzflua.files)
map("n", "<leader>sh", fzflua.helptags)
map("n", "<leader>sg", fzflua.live_grep_native)
map("n", "<leader>sr", fzflua.resume)
map("n", "<leader>sw", fzflua.grep_cword)
map("n", "<leader>sW", fzflua.grep_cWORD)

fzflua.setup({ "telescope", winopts = { preview = { default = "bat" } } })
