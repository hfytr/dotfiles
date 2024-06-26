local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local eopts = { noremap = true, expr = true, silent = true }

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

map("n", "<leader>bc", ":! g++ % -o %:r <CR>", { desc = "build current cpp FILE" })
map("n", "<leader>c", function()
    require("notify").dismiss()
end, opts)

map("n", "U", "<C-r>")
map("n", "<leader>o", function()
    local width = math.max(math.floor(vim.api.nvim_win_get_width(0) / 5), 30)
    vim.cmd("echo " .. tostring(width))
    vim.cmd("vsplit | wincmd h | vertical resize " .. tostring(width))
    require("oil").open()
end, opts)
map("n", "<leader>O", function()
    require("oil").open()
end, opts)
