{ config, pkgs, lib, ... }:
let rrtui = import ./rrtui.nix { inherit pkgs; };
in {
  imports = [
    ./pywalfox.nix
    ./swaync.nix
    ./fish.nix
    ./fastfetch.nix
    ./starship.nix
    ./neomutt.nix
    ./tmux.nix
    ./discord
    ./firefox
    ./hypr
    ./waybar
    ./kitty
    ./rofi
    ./wal
    ./nvim
    ./scripts
    ./wlogout
  ];

  home.username = "fbwdw";
  home.homeDirectory = "/home/fbwdw";

  home.stateVersion = "23.11";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (_: true);
  
  home.packages = with pkgs; [
    bc
    blender
    btop
    cava
    curl
    dbus
    eza
    git
    feh
    fzf
    gcalcli
    gitleaks
    hevea
    imagemagick
    just
    jq
    texliveMedium
    libinput
    lldb
    mkpasswd
    neomutt
    nixpkgs-fmt
    nix-prefetch-github
    nsxiv
    obsidian
    ollama
    playerctl
    pipes-rs
    ripgrep
    rrtui
    slurp
    # steam
    stylua
    toybox
    telegram-desktop
    unzip
    vial
    vscode
    zathura
    zoxide
    zoom
  ];

  home.file = {};

  home.sessionVariables = {
    EDITOR = "nvim";
    GIT_EDITOR = "nvim";
    PATH = "$PATH:/home/fbwdw/.nix-profile/bin/:/home/fbwdw/.local/bin:/home/fbwdw/.cargo/bin";
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  programs.home-manager.enable = true;
  # programs.catppuccin.flavor = "mocha";
  programs.zoxide.enable = true;
}
