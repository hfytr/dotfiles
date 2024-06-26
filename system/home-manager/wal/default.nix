{ pkgs, config, lib,... }:
{
  home.packages = [ pkgs.pywal ];

  home.file = lib.mkMerge [{
    ".config/wal/templates/colors-hyprland.conf".source = ./colors-hyprland.conf;
    ".config/wal/templates/rofi-transparent.rasi".source = ./rofi-transparent.rasi;
  }];
}
