{ pkgs, lib, ... }: {
  programs.ranger.enable = true;
  programs.ranger.settings = {
    preview_images = true;
    preview_images_method = "kitty";
    use_preview_script = true;
    preview_script = "~/.config/ranger/scope.sh";
    show_hidden = true;
    line_numbers = "relative";
  };
  programs.ranger.extraConfig = ''
    default_linemode devicons2
  '';
  programs.ranger.plugins = [
    {
      name = "zoxide";
      src = builtins.fetchGit {
        url = "https://github.com/jchook/ranger-zoxide";
        rev = "281828de060299f73fe0b02fcabf4f2f2bd78ab3";
      };
    }
    {
      name = "devicons2";
      src = builtins.fetchGit {
        url = "https://github.com/cdump/ranger-devicons2";
        rev = "9606009aa01743768b0f27de0a841f7d8fe196c5";
      };
    }
  ];
  home.file.".config/ranger/scope.sh".source = ./scope.sh;
}
