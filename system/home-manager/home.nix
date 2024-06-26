{ config, pkgs, lib, ... }:
{
  imports = [
    ./pywalfox.nix
    ./fish.nix
    ./fastfetch.nix
    ./starship.nix
    ./neomutt.nix
    ./tmux.nix
    ./hypr
    ./waybar
    ./kitty
    ./rofi
    ./wal
    ./nvim
    ./scripts
  ];

  home.username = "fbwdw";
  home.homeDirectory = "/home/fbwdw";

  home.stateVersion = "23.11";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (_: true);
  
  home.packages = with pkgs; [
    bc
    betterdiscordctl
    blender
    btop
    cava
    curl
    dbus
    discord
    eza
    git
    feh
    firefox
    fzf
    gitleaks
    hevea
    imagemagick
    just
    jq
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
    ripgrep
    rustup
    slurp
    stylua
    toybox
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
    RUST_BACKTRACE = 1;
    PATH = "$PATH:/home/fbwdw/.nix-profile/bin/:/home/fbwdw/.local/bin";
  };

  programs.home-manager.enable = true;
  # programs.catppuccin.flavor = "mocha";
  programs.zoxide.enable = true;
}
