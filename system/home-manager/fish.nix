{ pkgs, lib, ... }: {
  programs.fish = {
    enable = true;
    catppuccin.enable = true;

    shellAliases = {
      lsv = "eza -a -l -b -h -m --group-directories-first --icons=auto --color=auto";
      ls = "eza -a -b -h -m --group-directories-first --icons=auto --color=auto";
      nixs = "sudo nixos-rebuild switch --flake /home/fbwdw/nixos/#fbwdwNixos";
      sshi = "eval (ssh-agent -c) && ssh-add ~/.private/git";
      ns = "NIXPKGS_ALLOW_UNFREE=1 nix-shell";
      tma = "tmux new -A -s";
      tmk = "tmux kill-server";
      fastfetch-tmux = "kitten icat --align=left ~/nixos/assets/maro.png| fastfetch --raw - --logo-width 20 --logo-height 12";
    };

    functions.fish_greeting = "fastfetch-tmux";

    shellAbbrs = {
      gca = "git commit --amend -m \"$(git log -1 --pretty=%B)\"";
    };

    interactiveShellInit = ''
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
    '';

    # fish_greeting doesnt work with kitty images
    shellInitLast = ''
      fish_vi_key_bindings
      zoxide init fish --cmd cd | source
      starship init fish | source
      enable_transience
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
    '';
  };

  programs.bat.enable = true;
  programs.bat.catppuccin.enable = true;
}
