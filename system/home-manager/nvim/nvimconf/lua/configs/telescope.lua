local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local eopts = { noremap = true, expr = true, silent = true }

local actions = require("telescope.actions")
function send_to_unfocused_qf(prompt_bufnr)
    actions.send_to_qflist(prompt_bufnr)
    vim.cmd("copen")
    vim.cmd("wincmd p")
end

require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<C-u>"] = false,
                ["<C-d>"] = false,
                ["<C-q>"] = send_to_unfocused_qf,
            },
            n = {
                ["<C-q>"] = send_to_unfocused_qf,
            },
        },
    },
})

local function telescope_live_grep_open_files()
    require("telescope.builtin").live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
    })
end
local telescope = require("telescope.builtin")
require("telescope").setup({
    pickers = {
        find_files = {
            hidden = true,
        },
    },
})
map("n", "<leader>sf", telescope.find_files, { desc = "[S]earch [F]iles" })
map("n", "<leader>sh", telescope.help_tags, { desc = "[S]earch [H]elp" })
map("n", "<leader>sw", telescope.grep_string, { desc = "[S]earch current [W]ord" })
map("n", "<leader>sg", telescope.live_grep, { desc = "[S]earch by [G]rep" })
map("n", "<leader>sr", telescope.resume, { desc = "[S]earch [R]esume" })
