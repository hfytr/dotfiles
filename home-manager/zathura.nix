{ pkgs, lib, ... }: {
  programs.zathura.enable = true; 
  programs.zathura.options = {
    statusbar-home-tilde = true;
  };
  programs.zathura.extraConfig = ''
    set selection-clipboard clipboard
    set incremental-search true
    set recolor true
  '';
}
