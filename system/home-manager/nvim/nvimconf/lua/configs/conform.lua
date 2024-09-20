require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "black", "isort" },
        cpp = { "clang_format" },
        rust = { "rustfmt" },
        markdown = { "deno_fmt" },
    },
    format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
    },
})

require("conform").formatters.shfmt = {
    prepend_args = { "-style=file" },
}
