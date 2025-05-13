local opts = { noremap = true, silent = true }
vim.keymap.set({ 'i', 'n' }, '<C-f>', function()
    local blink = require('blink.cmp')
    if blink.is_documentation_visible() then
        blink.scroll_documentation_down()
    else
        vim.cmd('cnext')
    end
end, opts)
vim.keymap.set({ 'i', 'n' }, '<C-b>', function()
    local blink = require('blink.cmp')
    if blink.is_documentation_visible() then
        blink.scroll_documentation_up()
    else
        vim.cmd('cprev')
    end
end, opts)

require('blink.cmp').setup({
    appearance = { nerd_font_variant = 'mono' },
    fuzzy = { implementation = 'prefer_rust_with_warning' },
    signature = { enabled = true },
    sources = { default = { 'lsp', 'path', 'buffer' } },
    keymap = {
        preset = 'none',
        ['<C-a>'] = { 'accept' },
        ['<C-p>'] = { 'select_prev' },
        ['<C-n>'] = { 'select_next' },
    },
    completion = {
        menu = {
            draw = {
                columns = {
                    { 'label', 'label_description', gap = 1 },
                    { 'kind' },
                },
            },
            max_height = 20,
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 0,
        },
        ghost_text = { enabled = true },
    },
})
