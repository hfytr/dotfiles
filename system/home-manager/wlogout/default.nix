{ pkgs, config, lib,... }:
{
  home.packages = [ pkgs.wlogout ];

  home.file =
    lib.mkMerge [
      {
        ".config/wlogout/layout".source = ./layout;
        ".config/wlogout/style.css".source = ./style.css;
      }
    ];
}
