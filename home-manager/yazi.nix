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
    plugin.prepend_previewers = [{
        name = "*/";
        run = "eza-preview";
    }];
  };

  programs.yazi.keymap.manager.prepend_keymap = map (i: {
    on = [ i ];
    run = "plugin relative-motions --args=${i}";
    desc = "Move in relative jumps";
  }) (map toString (builtins.genList (i: i + 1) 9));

  programs.yazi.initLua = ''
    require("relative-motions"):setup({
      show_numbers="relative_absolute",
      show_motion = true
    })
  '';

  programs.yazi.plugins = {
    eza-preview = pkgs.fetchFromGitHub {
      owner = "sharklasers996";
      repo = "eza-preview.yazi";
      rev = "7ca4c2558e17bef98cacf568f10ec065a1e5fb9b";
      hash = "sha256-ncOOCj53wXPZvaPSoJ5LjaWSzw1omHadKDrXdIb7G5U=";
    };
    relative-motions = pkgs.fetchFromGitHub {
      owner = "dedukun";
      repo = "relative-motions.yazi";
      rev = "4244639d480e797a43d6514ddee021a0cb6d1cd6";
      hash = "sha256-83cTNxGbPzzWEGTwkpf/WweHuKJSAPIGLf4DzY9vqog=";
    };
  };
}
