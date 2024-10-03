{ pkgs, config, lib,... }:
{
  home.packages = [ pkgs.zathura ];
  home.file.".config/zathura/zathurarc".source = ./zathurarc;
}
