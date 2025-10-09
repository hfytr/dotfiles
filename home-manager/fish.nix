{ pkgs, lib, ... }: {
  programs.fish = {
    enable = true;

    shellAliases = {
      ls = "eza -abhm --group-directories-first --icons=auto --color=auto";
      nixs = "sudo nixos-rebuild switch --flake /home/fbwdw/nixos/#fbwdwNixos";
      nixu = "set -x NIXPKGS_ALLOW_UNFREE 1";
      "nv." = "nvim (fzf)";
      "rsdoc" = "echo (rustc --print sysroot)/share/doc/rust/html/index.html | wl-copy";
      cloc = "cloc (git ls-files)";
    };
    functions.fish_greeting = "";
    shellAbbrs = {
      lsr = "eza -abhmT --group-directories-first --icons=auto --color=auto -L";
      sshi = "eval (ssh-agent -c) && ssh-add ~/.private/";
    };
    shellInitLast = ''
      fish_vi_key_bindings
      zoxide init fish --cmd cd | source
      starship init fish | source
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
    '';
  };
}
