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
  }) (map toString (builtins.genList (i: i + 1) 9))
  ++ [
    { on = [ "E" ]; run = "plugin eza-preview";  desc = "Toggle tree/list dir preview"; }
    { on = [ "-" ]; run = "plugin eza-preview --args='--inc-level'"; desc = "Increment tree level"; }
    { on = [ "_" ]; run = "plugin eza-preview --args='--dec-level'"; desc = "Decrement tree level"; }
  ];

  programs.yazi.initLua = ''
    require("relative-motions"):setup({
      show_numbers="relative_absolute",
      show_motion = true,
    })
    require("eza-preview"):setup({
      level = 2,
      follow_symlinks = false,
      dereference = false,
    })
  '';

  programs.yazi.plugins = {
    eza-preview = pkgs.fetchFromGitHub {
      owner = "ahkohd";
      repo = "eza-preview.yazi";
      rev = "245a1d9c61bbb94063e8ea0746a1a29ac81fee94";
      hash = "sha256-L7i+uL2kAx3AUr5EAzRrduoV2m4+/tE1gCfbTOSuAc4=";
    };
    relative-motions = pkgs.fetchFromGitHub {
      owner = "dedukun";
      repo = "relative-motions.yazi";
      rev = "4244639d480e797a43d6514ddee021a0cb6d1cd6";
      hash = "sha256-83cTNxGbPzzWEGTwkpf/WweHuKJSAPIGLf4DzY9vqog=";
    };
  };
}
