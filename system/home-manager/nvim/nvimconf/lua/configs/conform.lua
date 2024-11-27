require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "black", "isort" },
        cpp = { "clang_format" },
        rs = { "rustfmt" },
        md = { "deno_fmt" },
    },
    format_after_save = { lsp_format = "fallback" },
    format = {
        latexindent = {
            inherit = false,
            command = "latexindent.pl",
            args = { "-s", "-m", "-g=/dev/null", '-l="latexindent.yaml"', "$FILENAME", "-o", "$FILENAME" },
        },
    },
})
