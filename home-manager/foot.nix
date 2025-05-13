{ pkgs, config, lib, ... }: 
let colors = config.lib.stylix.colors;
in {
  programs.foot.enable = true;
  programs.foot.settings.cursor.color = "${colors.base00} ${colors.base05}";
  programs.foot.settings= {
    main = {
      term = "xterm-256color";
      letter-spacing = 0.25;
      pad = "5x2";
    };
    key-bindings = {
      "clipboard-copy" = "none";
      "spawn-terminal" = "none";
      "show-urls-launch" = "none";
      "search-start" = "none";
      "unicode-input" = "none";
      "clipboard-paste" = "Control+Shift+v";
      "prompt-next" = "none";
      "prompt-prev" = "none";
    };
    text-bindings = lib.listToAttrs (map
        (letter: {
          name = "\\x1b[67;5u";
          value = "Alt+Shift+${lib.toLower letter}";
        })
        (lib.stringToCharacters "C"));
  };
}
