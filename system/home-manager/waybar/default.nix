{ pkgs, config, lib,... }:
{
  home.packages = [ pkgs.waybar ];

  home.file =
    lib.mkMerge [
      {
        ".config/waybar/config.json".source = ./config.json;
        ".config/waybar/style.css".source = ./style.css;
      }
    ];
}
