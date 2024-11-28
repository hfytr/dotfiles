{ pkgs, lib, config, ... }:
let colors = config.lib.stylix.colors;
in {
  stylix.targets.bemenu.enable = true;
  programs.bemenu.enable = true;
  # need to relogin to change
  programs.bemenu.settings = {
    list = 15;
    prompt = "open";
    ignorecase = true;
  };
}
