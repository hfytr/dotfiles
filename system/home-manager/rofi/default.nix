{ pkgs, config, lib,... }:
{
  home.packages = [ pkgs.rofi-wayland ];
  home.file.".config/rofi/launcherstyle.rasi".source = ./launcherstyle.rasi;
}
