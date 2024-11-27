{ pkgs, config, lib,... }:
{
  # deno for markdown formatting
  home.packages = [ pkgs.neovim pkgs.deno ];
  xdg.configFile.nvim.source = ./nvimconf;
}
