{ pkgs, lib, config, ... }:
let colors = config.lib.stylix.colors.withHashtag;
in {
  programs.librewolf.enable = true;
  programs.librewolf.profiles.default = {
    settings = {
      "browser.startup.homepage" = "https://xkcd.com";
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      "sidebar.verticalTabs" = true;
      "sidebar.revamp" = true;
      "browser.toolbars.bookmarks.visibility" = "never";
      "ui.key.menuAccessKeyFocuses" = false;
      "security.fileuri.strict_origin_policy" = false;
    };
    userChrome = ''
      :root {
        --toolbox-non-lwt-bgcolor: ${colors.base00};
      }
      sidebar-main[expanded] div#vertical-tabs {
          width: 300px !important;
          max-width: none !important;
      }
      sidebar-main {
        background-color: ${colors.base00} !important;
      }
      navigator-toolbox {
        background-color: ${colors.base00} !important;
      }
      #nav-bar {
          background-color: ${colors.base00} !important;
          color: var(--lwt-toolbar-field-color, FieldText) !important;
      }
      #sidebar-main:-moz-window-inactive {
          background-color: ${colors.base00} !important;
      }
      #urlbar {
          background-color: ${colors.base00} !important;
          color: var(--lwt-toolbar-field-color, FieldText) !important;
      }
      #urlbar input::selection {
          background-color: transparent !important;
          color: var(--lwt-toolbar-field-color, FieldText) !important;
      }
      .titlebar-spacer[type="pre-tabs"] {
          display: none !important;
      }
    '';
  };
}
