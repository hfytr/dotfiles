{ pkgs, config, lib,... }:
let 
  colors = config.lib.stylix.colors.withHashtag;
in {
  home.packages = with pkgs; [
    betterdiscordctl
    discord
  ];
  home.file.".config/BetterDiscord/themes/stylix-theme.theme.css".text = ''
    /**
     * @name ClearVision
     * @author ClearVision Team
     * @version 6.9.0
     * @description Highly customizable theme for BetterDiscord.
     * @source https://github.com/ClearVision/ClearVision-v6
     * @website https://clearvision.github.io
     * @invite dHaSxn3
     */
    
    /* Credits to Zerthox for making the original theme. */
    
    /* IMPORT CSS */
    @import url(https://clearvision.github.io/ClearVision-v6/main.css);
    
    /* SETTINGS */
    :root {
      /* ACCENT COLORS */
      --main-color: ${colors.base04};
      --hover-color: ${colors.base05};
      --success-color: ${colors.base0B};
      --danger-color: ${colors.base08};
      --url-color: ${colors.base09};
    
      /* STATUS COLORS */
      --online-color: ${colors.base0B};
      --idle-color: ${colors.base0A};
      --dnd-color: ${colors.base08};
      --streaming-color: ${colors.base0E};
      --offline-color: ${colors.base03};
    
      /* GENERAL */
      --main-font: JetBrains Mono;
      --code-font: JetBrains Mono;
      --text-normal: rgb(220, 221, 222);
      --text-muted: rgb(114, 118, 125);
      --channels-width: 220px;
      --members-width: 240px;
      --server-unread: var(--main-color);
    
      /* APP BACKGROUND */
      --background-shading: 100%;
      --background-overlay: rgb(${colors.base08});
      --background-image: none;
      --background-position: center;
      --background-size: cover;
      --background-repeat: no-repeat;
      --background-attachment: fixed;
      --background-brightness: 100%;
      --background-contrast: 100%;
      --background-saturation: 100%;
      --background-invert: 0%;
      --background-grayscale: 0%;
      --background-sepia: 0%;
      --background-blur: 0px;
    
      /* HOME BUTTON ICON */
      --home-icon: url(https://clearvision.github.io/icons/discord.svg);
      --home-position: center;
      --home-size: 40px;
    
      /* CHANNEL COLORS */
      --channel-unread: var(--main-color);
      --channel-color: rgba(255, 255, 255, 0.3);
      --channel-text-selected: #fff;
      --muted-color: rgba(255, 255, 255, 0.1);
    
      /* MODAL BACKDROP */
      --backdrop-overlay: rgba(0, 0, 0, 0.8);
      --backdrop-image: var(--background-image);
      --backdrop-position: var(--background-position);
      --backdrop-size: var(--background-size);
      --backdrop-repeat: var(--background-repeat);
      --backdrop-attachment: var(--background-attachment);
      --backdrop-brightness: var(--background-brightness);
      --backdrop-contrast: var(--background-contrast);
      --backdrop-saturation: var(--background-saturation);
      --backdrop-invert: var(--background-invert);
      --backdrop-grayscale: var(--background-grayscale);
      --backdrop-sepia: var(--background-sepia);
      --backdrop-blur: var(--background-blur);
    
      /* USER POPOUT BACKGROUND */
      --user-popout-image: var(--background-image);
      --user-popout-position: var(--background-position);
      --user-popout-size: var(--background-size);
      --user-popout-repeat: var(--background-repeat);
      --user-popout-attachment: var(--background-attachment);
      --user-popout-brightness: var(--background-brightness);
      --user-popout-contrast: var(--background-contrast);
      --user-popout-saturation: var(--background-saturation);
      --user-popout-invert: var(--background-invert);
      --user-popout-grayscale: var(--background-grayscale);
      --user-popout-sepia: var(--background-sepia);
      --user-popout-blur: calc(var(--background-blur) + 3px);
      --user-popout-overlay: rgba(0, 0, 0, 0.6);
    
      /* USER MODAL BACKGROUND */
      --user-modal-image: var(--background-image);
      --user-modal-position: var(--background-position);
      --user-modal-size: var(--background-size);
      --user-modal-repeat: var(--background-repeat);
      --user-modal-attachment: var(--background-attachment);
      --user-modal-brightness: var(--background-brightness);
      --user-modal-contrast: var(--background-contrast);
      --user-modal-saturation: var(--background-saturation);
      --user-modal-invert: var(--background-invert);
      --user-modal-grayscale: var(--background-grayscale);
      --user-modal-sepia: var(--background-sepia);
      --user-modal-blur: calc(var(--background-blur) + 3px);
    
      /* THEME BD COLORS */
      --bd-blue: var(--main-color);
      --bd-blue-hover: var(--hover-color);
      --bd-blue-active: var(--hover-color);
    }
  '';
}
# base00: "#1d2021" # ----
# base01: "#3c3836" # ---
# base02: "#504945" # --
# base03: "#665c54" # -
# base04: "#bdae93" # +
# base05: "#d5c4a1" # ++
# base06: "#ebdbb2" # +++
# base07: "#fbf1c7" # ++++
# base08: "#fb4934" # red
# base09: "#fe8019" # orange
# base0A: "#fabd2f" # yellow
# base0B: "#b8bb26" # green
# base0C: "#8ec07c" # aqua/cyan
# base0D: "#83a598" # blue
# base0E: "#d3869b" # purple
# base0F: "#d65d0e" # brown
