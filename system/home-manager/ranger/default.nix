{ pkgs, lib, ... }: {
  programs.ranger.enable = true;
  programs.ranger.settings = {
    preview_images = true;
    preview_images_method = "ueberzug";
    show_hidden = true;
    line_numbers = "relative";
    default_linemode = "devicons";
  };
  programs.ranger.plugins = [
    {
      name = "zoxide";
      src = builtins.fetchGit {
        url = "https://github.com/jchook/ranger-zoxide";
        rev = "281828de060299f73fe0b02fcabf4f2f2bd78ab3";
      };
    }
    {
      name = "devicons";
      src = builtins.fetchGit {
        url = "https://github.com/alexanderjeurissen/ranger_devicons";
        rev = "a8d626485ca83719e1d8d5e32289cd96a097c861";
      };
    }
  ];
  home.file.".config/ranger/scope.sh".source = ./scope.sh;
}
