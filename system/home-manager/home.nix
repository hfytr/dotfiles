{ config, pkgs, lib, ... }:
let rrtui = import ./rrtui.nix { inherit pkgs; };
in {
  imports = [
    ./pywalfox.nix
    ./swaync.nix
    ./fish.nix
    ./fastfetch.nix
    ./starship.nix
    ./ncmpcpp.nix
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
    arduino-ide
    bc
    blender
    btop
    cava
    curl
    dbus
    eza
    git
    feh
    ffmpeg_7
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
    (python312.withPackages (python-pkgs: with python-pkgs; [
     pyserial 
    ]))
    prismlauncher
    ripgrep
    rrtui
    slurp
    stylua
    toybox
    telegram-desktop
    unzip
    vial
    vlc
    vscode
    webtorrent_desktop
    yt-dlp
    zathura
    zoxide
    zoom
    zulu21
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
