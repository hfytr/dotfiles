{ pkgs, config, lib,... }:{
  home.file.".local/bin" = {
    source = ./scripts;
    recursive = true;
    executable = true;
  };
}
