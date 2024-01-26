local M = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black", "isort" },
    rust = { "rustfmt" },
    cpp = { "clang_format" },
  },
}

return M
