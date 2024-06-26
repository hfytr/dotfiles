require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "black", "isort" },
        cpp = { "clang_format" },
        rust = { "rustfmt" },
    },
    format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
    },
})

require("conform").formatters.shfmt = {
    prepend_args = { "-style=file" },
}
