local map = vim.keymap.set
local modes = {'n', 'i', 'x', 'v'}
local opts = { noremap = true, silent = true }

require("neomarks").setup({
    storagefile = vim.fn.stdpath("data") .. "/neomarks.json",
    menu = {
        title = "Neomarks",
        title_pos = "center",
        border = "rounded",
        width = 60,
        height = 10,
    },
})

local neomarks = require("neomarks")
vim.keymap.set("n", "<leader>aa", function()
    neomarks.mark_file()
end)
vim.keymap.set("n", "<leader>al", function()
    neomarks.menu_toggle()
end)

-- gallium layout
map(modes, "<C-g>", function()
    neomarks.jump_to(5)
end)
map(modes, "<C-s>", function()
    neomarks.jump_to(4)
end)
map(modes, "<C-t>", function()
    neomarks.jump_to(3)
end)
map(modes, "<C-r>", function()
    neomarks.jump_to(2)
end)
map(modes, "<C-n>", function()
    neomarks.jump_to(1)
end)
