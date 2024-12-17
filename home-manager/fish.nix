{ pkgs, lib, ... }: {
  programs.fish = {
    enable = true;

    shellAliases = {
      ls = "eza -abhm --group-directories-first --icons=auto --color=auto";
      nixs = "sudo nixos-rebuild switch --flake /home/fbwdw/nixos/#fbwdwNixos";
      sshi = "eval (ssh-agent -c) && ssh-add ~/.private/git";
      ns = "NIXPKGS_ALLOW_UNFREE=1 nix-shell";
      tma = "tmux new -A -s";
      tmk = "tmux kill-server";
      fastfetch = "fastfetch --logo \"$(pokeget random --hide-name)\" --logo-type data";
      nixu = "set -x NIXPKGS_ALLOW_UNFREE 1";
      "nv." = "nvim (fzf)";
      nv = "nvim";
      ra = "ranger";
    };

    functions.fish_greeting = "fastfetch";

    shellAbbrs = {
      gca = "git commit --amend -m \"$(git log -1 --pretty=%B)\"";
      lsr = "eza -abhmT --group-directories-first --icons=auto --color=auto -L";
    };

    interactiveShellInit = ''
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
    '';

    # fish_greeting doesnt work with kitty images
    shellInitLast = ''
      fish_vi_key_bindings
      zoxide init fish --cmd cd | source
      starship init fish | source
      eval (ssh-agent -c) && ssh-add ~/.private/git
      set -x RUST_BACKTRACE 1
      clear
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
    '';
  };

  programs.bat.enable = true;
}
