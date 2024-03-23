local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local eopts = { noremap = true, expr = true, silent = true }

map('i', '<C-h>', "<Left>", opts)
map('i', '<C-j>', "<Down>", opts)
map('i', '<C-k>', "<Up>", opts)
map('i', '<C-l>', "<Right>", opts)

map('n', 'k', "v:count == 0 ? 'gk' : 'k'", eopts)
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", eopts)
map('n', '<C-u>', function ()
  vim.cmd("normal! "..tostring(math.floor(vim.api.nvim_win_get_height(0)/2)).."kzz")
end, opts)
map('n', '<C-d>', function ()
  vim.cmd("normal! "..tostring(math.floor(vim.api.nvim_win_get_height(0)/2)).."jzz")
end, opts)

map('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })
-- idk but this wont work
-- vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})
-- map('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
local function telescope_live_grep_open_files()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end
map('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
local telescope = require'telescope.builtin'
map('n', '<leader>?', telescope.oldfiles, { desc = '[?] Find recently opened files' })
map('n', '<leader><space>', telescope.buffers, { desc = '[ ] Find existing buffers' })
map('n', '<leader>ss', telescope.builtin, { desc = '[S]earch [S]elect Telescope' })
map('n', '<leader>gf', telescope.git_files, { desc = 'Search [G]it [F]iles' })
map('n', '<leader>sf', telescope.find_files, { desc = '[S]earch [F]iles' })
map('n', '<leader>sh', telescope.help_tags, { desc = '[S]earch [H]elp' })
map('n', '<leader>sw', telescope.grep_string, { desc = '[S]earch current [W]ord' })
map('n', '<leader>sg', telescope.live_grep, { desc = '[S]earch by [G]rep' })
map('n', '<leader>sd', telescope.diagnostics, { desc = '[S]earch [D]iagnostics' })
map('n', '<leader>sr', telescope.resume, { desc = '[S]earch [R]esume' })
map('n','<leader>bc', ":! g++ % -o %:r <CR>", { desc = "build current cpp FILE"})

local harpoon = require("harpoon")
vim.keymap.set("n", "<leader>aa", function() harpoon:list():append() end)
local toggle_opts = {
  border = "rounded",
  title_pos = "center",
  ui_width_ratio = 0.40,
}
vim.keymap.set("n", "<leader>al", function() harpoon.ui:toggle_quick_menu(harpoon:list(), toggle_opts) end)

vim.keymap.set("n", "<A-y>", function() harpoon:list():select(5) end)
vim.keymap.set("n", "<A-u>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<A-i>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<A-o>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<A-p>", function() harpoon:list():select(4) end)

map('n', '<leader>f', ':edit . <CR>', { desc = "oil [F]ile system in current dir" })
map('n', '<leader>tt', ":NvimTreeToggle <CR>")

map("n", '<leader>db', ":lua require'dap'.toggle_breakpoint() <CR>", { desc = "[D]ap toggle [B]reakpoint" })
map("n", '<leader>ds', ":RustLsp debuggables", { desc = "[D]ebugger [S]tart - Rust Only" })
map("n", '<F10>', ":lua require'dap'.step_over() <CR>", { desc = "[D]ap toggle [B]reakpoint" })
map("n", '<F11>', ":lua require'dap'.step_into() <CR>", { desc = "[D]ap toggle [B]reakpoint" })
map("n", '<F12>', ":lua require'dap'.step_out() <CR>", { desc = "[D]ap toggle [B]reakpoint" })
map("n", '<F5>', ":lua require'dap'.continue() <CR>", { desc = "[D]ap toggle [B]reakpoint" })
