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
    prismlauncher
    ripgrep
    rrtui
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
    # zulu17
    zulu8
  ];

  home.file = {};

  home.sessionVariables = {
    EDITOR = "nvim";
    GIT_EDITOR = "nvim";
    RUST_BACKTRACE = 1;
    PATH = "$PATH:/home/fbwdw/.nix-profile/bin/:/home/fbwdw/.local/bin:/home/fbwdw/.cargo/bin";
  };

  programs.home-manager.enable = true;
  # programs.catppuccin.flavor = "mocha";
  programs.zoxide.enable = true;
}
