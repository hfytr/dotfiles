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
      #sidebar-main:-moz-window-inactive {
          background-color: ${colors.base00} !important;
      }
    '';
  };
  # home.file.".librewolf/librewolf.overrides.cfg".text = ''
  #   defaultPref("network.file.disable_unc_paths", false);
  # '';
}
