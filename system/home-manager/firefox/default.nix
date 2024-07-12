{ pkgs, config, lib,... }:
{
  home.packages = [ pkgs.firefox ];

  home.file = {
    ".mozilla/firefox/trpcdpo2.default/chrome/theme" = {
      source = ./theme;
      recursive = true;
    };
    ".mozilla/firefox/trpcdpo2.default/chrome/userChrome.css".source = ./userChrome.css;
    ".mozilla/firefox/trpcdpo2.default/chrome/userContent.css".source = ./userContent.css;
    ".mozilla/firefox/trpcdpo2.default/user.js".source = ./user.js;
  };
}
