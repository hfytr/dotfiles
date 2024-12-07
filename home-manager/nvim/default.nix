{ pkgs, config, lib,... }:
let colors = config.lib.stylix.colors.withHashtag;
in {
  # deno for markdown formatting
  home.packages = [ pkgs.neovim pkgs.deno ];
  home.file.".config/nvim" = {
    source = ./nvimconf;
    recursive = true;
  };
  home.file.".config/nvim/lazy-lock.json".source = ./nvimconf/lazy-lock.json;
  home.file.".config/nvim/init.lua".source = ./nvimconf/init.lua;
  home.file.".config/nvim/lua/mappings.lua".source = ./nvimconf/lua/mappings.lua;
  home.file.".config/nvim/lua/plugins.lua".source = ./nvimconf/lua/plugins.lua;
  home.file.".config/nvim/lua/configs" = {
    source = ./nvimconf/lua/configs;
    recursive = true;
  };
  home.file.".config/fourmolu.yaml".text = ''
    indentation: 2
    column-limit: 80
    in-style: no-space
  '';
  home.file.".config/nvim/lua/base16.lua".text = ''
    require('base16-colorscheme').with_config({
        telescope = false,
        indentblankline = false,
        notify = false,
        ts_rainbow = false,
        cmp = true,
        illuminate = false,
        dapui = false,
    })
    require('base16-colorscheme').setup({
        base00 = '${colors.base00}', base01 = '${colors.base01}', base02 = '${colors.base02}', base03 = '${colors.base03}',
        base04 = '${colors.base04}', base05 = '${colors.base05}', base06 = '${colors.base05}', base07 = '${colors.base07}',
        base08 = '${colors.base08}', base09 = '${colors.base09}', base0A = '${colors.base0A}', base0B = '${colors.base0B}',
        base0C = '${colors.base0C}', base0D = '${colors.base0D}', base0E = '${colors.base0E}', base0F = '${colors.base0F}',
    })
  '';
}
