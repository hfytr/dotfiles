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
        ".config/BetterDiscord/plugins/CallTimeCounter.plugin.js".source = ./CallTimeCounter.plugin.js;
        ".config/BetterDiscord/plugins/DoubleClickToEdit.plugin.js".source = ./DoubleClickToEdit.plugin.js;
        ".config/BetterDiscord/plugins/SplitLargeMessages.plugin.js".source = ./SplitLargeMessages.plugin.js;
        ".config/BetterDiscord/plugins/TypingIndicator.plugin.js".source = ./TypingIndicator.plugin.js;
        ".config/BetterDiscord/plugins/FileViewer.plugin.js".source = ./FileViewer.plugin.js;
        ".config/BetterDiscord/plugins/ReadAllNotificationsButton.plugin.js".source = ./ReadAllNotificationsButton.plugin.js;
        ".config/BetterDiscord/plugins/DiscordFreeEmojis64px.plugin.js".source = ./DiscordFreeEmojis64px.plugin.js;
        ".config/BetterDiscord/plugins/0BDFDB.plugin.js".source = ./0BDFDB.plugin.js;
        ".config/BetterDiscord/plugins/0PluginLibrary.plugin.js".source = ./0PluginLibrary.plugin.js;
      }
    ];
}
