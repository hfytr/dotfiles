local M = {}

M.general = {
  n = {
    ["<C-u>"] = {"<C-u>zz"},
    ["<C-d>"] = {"<C-d>zz"},
  }
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = { ":DapToggleBreakpoint<CR>", "Toggle Breakpoint" },
    ["<leader>dr"] = { ":DapContinue", "Start / Continue" },
    ["<leader>di"] = { ":DapStepInto", "Step Into" },
    ["<leader>dn"] = { ":DapStepOver", "Step Over" },
    ["<leader>do"] = { ":DapStepOut", "Step Out" },
  }
}

return M
