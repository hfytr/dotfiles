{ pkgs, config, lib, ... }:
let colors = config.lib.stylix.colors.withHashtag;
in {
  # deno for markdown formatting
  home.packages = [ pkgs.neovim ];
  home.file.".config/nvim" = {
    source = ./nvimconf;
    recursive = true;
  };
  home.file.".config/nvim/lazy-lock.json".source = ./nvimconf/lazy-lock.json;
  home.file.".config/nvim/init.lua".source = ./nvimconf/init.lua;
  home.file.".config/nvim/lua/mappings.lua".source = ./nvimconf/lua/mappings.lua;
  home.file.".config/nvim/lua/plugins.lua".source = ./nvimconf/lua/plugins.lua;
  home.file.".config/nvim/lua/lsp.lua".source = ./nvimconf/lua/lsp.lua;
  home.file.".config/nvim/lua/cmp.lua".source = ./nvimconf/lua/cmp.lua;
  home.file.".config/fourmolu.yaml".text = ''
    indentation: 2
    in-style: right-align
    indent-wheres: true
  '';
  home.file.".config/nvim/lua/base16.lua".text = ''
    local base16 = require('base16-colorscheme')
    base16.with_config({
        telescope = false,
        indentblankline = false,
        notify = false,
        ts_rainbow = false,
        cmp = true,
        illuminate = false,
        dapui = false,
    })
    base16.setup({
        base00 = '${colors.base00}', base01 = '${colors.base01}', base02 = '${colors.base02}', base03 = '${colors.base03}',
        base04 = '${colors.base04}', base05 = '${colors.base05}', base06 = '${colors.base05}', base07 = '${colors.base07}',
        base08 = '${colors.base08}', base09 = '${colors.base09}', base0A = '${colors.base0A}', base0B = '${colors.base0B}',
        base0C = '${colors.base0C}', base0D = '${colors.base0D}', base0E = '${colors.base0E}', base0F = '${colors.base0F}',
    })
    vim.cmd('hi Delimiter guifg='..base16.colors.base05)
    vim.cmd('hi Folded guibg=None')
    vim.cmd('hi ColorColumn guibg='..base16.colors.base02)
  '';
}
