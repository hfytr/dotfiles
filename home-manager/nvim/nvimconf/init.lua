vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.termguicolors = true

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local highlight_group =
    vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*.txt',
    callback = function()
        if vim.b.disable_txt_format or vim.g.disable_txt_format then
            return
        end
        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
        vim.cmd('normal! G0Vgggq')
        vim.api.nvim_win_set_cursor(0, { row, col })
    end,
})

vim.keymap.set('n', "<leader>gq", function()
    vim.g.disable_txt_formet=True
end)

vim.api.nvim_create_autocmd('TermClose', {
    pattern = 'term://*yazi',
    callback = function()
        vim.api.nvim_input('<CR>')
    end,
})
vim.api.nvim_create_autocmd('BufWritePost', { command = 'mkview' })
vim.api.nvim_create_autocmd('BufReadPost', {
    command = 'silent! loadview',
})

local shiftwidths = {
    haskell = 2,
    nix = 2,
}
local default_shiftwidth = 4
vim.api.nvim_create_autocmd('BufEnter', {
    callback = function()
        vim.bo.shiftwidth = shiftwidths[vim.bo.filetype] or default_shiftwidth
    end,
})

vim.o.showmode = false
vim.o.guicursor =
    'n-v-c:block,i-r-ci-cr-sm:block-blinkwait0-blinkon30-blinkoff30'
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 15
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.foldmethod = 'indent'
vim.o.foldlevel = 420
vim.o.conceallevel = 0
vim.o.statusline = '%#Normal# %F%m%r%=%l:%c | %{&filetype} '
vim.o.hlsearch = false
vim.wo.number = true
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'no'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.disable_txt_format = true

require('plugins')
require('nvim-highlight-colors').turnOn()
require('mappings')
-- require('completions')
