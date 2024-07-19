{ pkgs, config, lib,... }:
{
  home.packages = [ pkgs.firefox ];

  home.file = {
    ".mozilla/firefox/i57zxbwd.default/chrome/theme" = {
      source = ./theme;
      recursive = true;
    };
    ".mozilla/firefox/i57zxbwd.default/chrome/userChrome.css".source = ./userChrome.css;
    ".mozilla/firefox/i57zxbwd.default/chrome/userContent.css".source = ./userContent.css;
    ".mozilla/firefox/i57zxbwd.default/user.js".source = ./user.js;
  };
}
