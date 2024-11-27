{ pkgs, config, lib,... }: {
  home.packages = with pkgs; [
    betterdiscordctl
    discord
  ];
  home.file.".config/BetterDiscord/themes/catppuccinclear.theme.css".source = ./catppuccinclear.theme.css;
}
