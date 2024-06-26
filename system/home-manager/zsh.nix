{ pkgs, lib, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    dotDir = ".config/zsh";

    shellAliases = {
      lsv = "eza -a -l -b -h -m --group-directories-first --icons=auto --color=auto";
      ls = "eza -a -b -h -m --group-directories-first --icons=auto --color=auto";
      nixs = "sudo nixos-rebuild switch --flake /home/fbwdw/nixos/#fbwdwNixos";
    };

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } 
        { name = "zsh-users/zsh-syntax-highlighting"; }
        { name = "catppuccin/zsh-syntax-highlighting"; }
      ];
    };

    initExtra = ''
      eval `ssh-agent`
      ssh-add ~/.private/git
      eval "$(zoxide init zsh --cmd cd)"
      bleopt prompt_ps1_transient=trim
      bleopt prompt_ps1_final='$(starship module character)'
      clear
      pokeget random --hide-name
    '';
  };
}
