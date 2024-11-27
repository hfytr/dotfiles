{ pkgs, lib, config, ... }:
let colors = config.lib.stylix.colors;
in {
  stylix.targets.bemenu.enable = true;
  programs.bemenu.enable = true;
  # need to relogin to change
  programs.bemenu.settings = {
    line-height = 15;
    prompt = "open";
    ignorecase = true;
    # tb = colors.base00;
    # fb = colors.base01;
    # nb = colors.base02;
    # hb = colors.base03;
    # hf = colors.base04;
  };
}
