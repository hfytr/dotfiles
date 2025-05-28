{ pkgs, lib, ... }: {
  programs.fish = {
    enable = true;

    shellAliases = {
      ls = "eza -abhm --group-directories-first --icons=auto --color=auto";
      nixs = "sudo nixos-rebuild switch --flake /home/fbwdw/nixos/#fbwdwNixos";
      fastfetch = "fastfetch --logo \"$(pokeget random --hide-name)\" --logo-type data";
      nixu = "set -x NIXPKGS_ALLOW_UNFREE 1";
      "nv." = "nvim (fzf)";
      gr = "grep -r -i";
      yt-music = "yt-dlp -x --audio-format mp3";
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
      eval (ssh-agent -c) &> /dev/null
      ssh-add ~/.private/git &> /dev/null
      eval "$(ssh-agent -c 2>/dev/null)" && ssh-add ~/.private/git &>/dev/null
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
    '';
  };
}
