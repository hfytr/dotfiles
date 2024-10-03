require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "black", "isort" },
        cpp = { "clang_format" },
        rs = { "rustfmt" },
        md = { "deno_fmt" },
        tex = { "latexindent" },
    },
    format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
    },
    format = {
        latexindent = {
            inherit = false,
            command = "latexindent",
            args = { "-s", "-m", "-g=/dev/null", '-l="latexindent.yaml"', "$FILENAME", "-o", "$FILENAME" },
        },
    },
})
