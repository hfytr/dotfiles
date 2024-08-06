{ pkgs, config, lib,... }:
{
  home.packages = with pkgs; [
    betterdiscordctl
    discord
  ];

  home.file =
    lib.mkMerge [
      {
        ".config/BetterDiscord/themes/catppuccinclear.theme.css".source = ./catppuccinclear.theme.css;
        ".config/BetterDiscord/plugins/SplitLargeMessages.plugin.js".source = ./SplitLargeMessages.plugin.js;
        ".config/BetterDiscord/plugins/FileViewer.plugin.js".source = ./FileViewer.plugin.js;
        ".config/BetterDiscord/plugins/DiscordFreeEmojis64px.plugin.js".source = ./DiscordFreeEmojis64px.plugin.js;
      }
    ];
}
