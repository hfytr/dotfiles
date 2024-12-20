{ pkgs, lib, ... }: {
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
      sidebar-main[expanded] div#vertical-tabs {
          width: 300px !important;
          max-width: none !important;
      }
    '';
  };
}
