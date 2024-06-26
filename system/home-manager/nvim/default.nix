{ pkgs, config, lib,... }:
{
  home.packages = [ pkgs.neovim ];
  xdg.configFile.nvim.source = ./nvimconf;
}
