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

map("n", "U", "<C-r>", opts)

map("n", "<leader>y", function()
    vim.cmd("term yazi")
    vim.api.nvim_input("i")
end, opts)

local function show_all_diagnostics()
    local diagnostics = vim.diagnostic.get() -- Get all diagnostics
    if vim.tbl_isempty(diagnostics) then
        vim.notify("No diagnostics found!", vim.log.levels.INFO)
        return
    end

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

    local lines = {}
    for _, diag in ipairs(diagnostics) do
        local line = string.format("[%s] %s: %s",
            vim.fn.fnamemodify(diag.bufnr and vim.fn.bufname(diag.bufnr) or "", ":t"),
            diag.lnum + 1,
            diag.message)
        table.insert(lines, line)
    end
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    vim.api.nvim_command("vsplit")
    vim.api.nvim_set_current_buf(buf)
end

map("n", "<leader>e", show_all_diagnostics)

--[[
:set relativenumber
:set foldmethod=indent
:nnoremap <PageUp> :execute 'normal! ' . (winheight(0) / 2) . 'gkzz'<CR>
:vnoremap <PageUp> :execute 'normal! ' . (winheight(0) / 2) . 'gkzz'<CR>
:nnoremap <PageDown> :execute 'normal! ' . (winheight(0) / 2) . 'gjzz'<CR>
:vnoremap <PageDown> :execute 'normal! ' . (winheight(0) / 2) . 'gjzz'<CR>
]]
--
