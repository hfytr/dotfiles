{ pkgs, lib, ... }: {
  programs.yazi.enable = true;
  programs.yazi.enableFishIntegration = true;
  programs.yazi.settings = {
    manager = {
      show_hidden = true;
      show_symlink = true;
      scrolloff = 10;
      linemode = "size";
    };
    # plugin.prepend_previewers = [{
    #     name = "*/";
    #     run = "eza-preview";
    # }];
  };

  # programs.yazi.keymap.manager.prepend_keymap = [
  #   { on = [ "E" ]; run = "plugin eza-preview";  desc = "Toggle tree/list dir preview"; }
  #   { on = [ "-" ]; run = "plugin eza-preview --args='--inc-level'"; desc = "Increment tree level"; }
  #   { on = [ "_" ]; run = "plugin eza-preview --args='--dec-level'"; desc = "Decrement tree level"; }
  # ];

  # programs.yazi.initLua = ''
  #   require("eza-preview"):setup({
  #     level = 2,
  #     follow_symlinks = false,
  #     dereference = false,
  #   })
  # '';

  # programs.yazi.plugins = {
  #   eza-preview = pkgs.fetchFromGitHub {
  #     owner = "hfytr";
  #     repo = "eza-preview.yazi";
  #     rev = "63900acec5d2e1d8e8d81c57b0140d83a43faad0";
  #     hash = "sha256-QaDpn9Vd9I7j35Oy1BvnT7/TH1cTpe34NUSYvMEP0Q4=";
  #   };
  # };
}
