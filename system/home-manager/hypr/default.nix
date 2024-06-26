{ pkgs, config, lib,... }:
{
  home.packages = with pkgs; [
    swww
    hyprland
    hyprlock
    grim
    slurp
    swappy
    wl-clipboard
    brightnessctl
  ];

  home.file =
    lib.mkMerge [
      {
        ".config/hypr/hyprland.conf".source = ./hyprland.conf;
        ".config/hypr/binds.conf".source = ./binds.conf;
        ".config/hypr/startup.conf".source = ./startup.conf;
        ".config/hypr/hyprlock.conf".source = ./hyprlock.conf;
      }
    ];
}
