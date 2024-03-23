require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black", "isort" },
    cpp = { "clang_format" },
  },
})

require("conform").formatters.shfmt = {
    prepend_args = { "-style=file" },
}
