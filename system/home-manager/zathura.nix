{ pkgs, config, lib,... }:
{
  home.packages = [ pkgs.zathura ];
  home.file.".config/zathura/zathurarc".text = ''
    set selection-clipboard clipboard
    set incremental-search true
    set recolor true
  '';
}
