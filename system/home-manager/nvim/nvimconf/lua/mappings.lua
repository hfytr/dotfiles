local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local eopts = { noremap = true, expr = true, silent = true }

map("n", "$", "g$")
map("n", "0", "g0")
map("n", "k", "v:count == 0 ? 'gk' : 'k'", eopts)
map("n", "j", "v:count == 0 ? 'gj' : 'j'", eopts)
map({ "n", "v" }, "<PageUp>", function()
    vim.cmd("normal! " .. tostring(math.floor(vim.api.nvim_win_get_height(0) / 2)) .. "gkzz")
end, opts)
map({ "n", "v" }, "<PageDown>", function()
    vim.cmd("normal! " .. tostring(math.floor(vim.api.nvim_win_get_height(0) / 2)) .. "gjzz")
end, opts)
map("n", "n", "nzz", opts)
map("n", "N", "Nzz", opts)

map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "<leader>c", function()
    require("notify").dismiss()
end, opts)

map("n", "U", "<C-r>", opts)

map("n", "<leader>r", function()
    vim.cmd("term ranger")
    vim.api.nvim_input("i")
end, opts)
