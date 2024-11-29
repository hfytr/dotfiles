{ config, pkgs, lib, ... }:
let
  rrtui = import ./rrtui.nix { inherit pkgs; };
in {
  imports = [
    ./bemenu.nix
    ./discord.nix
    ./fish.nix
    ./fastfetch.nix
    ./kitty.nix
    ./ncmpcpp.nix
    ./nvim
    ./river
    ./starship.nix
    ./swaync.nix
    ./tmux.nix
    ./waybar.nix
    ./yazi.nix
    ./zathura.nix
  ];

  home.username = "fbwdw";
  home.homeDirectory = "/home/fbwdw";

  home.stateVersion = "23.11";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (_: true);
  
  home.packages = with pkgs; [
    arduino-ide
    bc
    brave
    dbus
    eza
    git
    feh
    ffmpeg_7
    fzf
    hevea
    (texlive.withPackages (ps: with ps; [
      scheme-basic latexmk etoolbox amsfonts amsmath hyperref geometry xetex
    ]))
    perl538Packages.LatexIndent
    libinput
    lutris
    lldb
    mkpasswd
    minicom
    nix-prefetch-github
    poppler_utils
    playerctl
    pokeget-rs
    (python312.withPackages (python-pkgs: with python-pkgs; [
     pyserial 
    ]))
    ripgrep
    rrtui
    slurp
    stylua
    unzip
    vial
    vlc
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    yt-dlp
    zathura
    zoxide
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    GIT_EDITOR = "nvim";
    PATH = "$PATH:/home/fbwdw/.nix-profile/bin/:/home/fbwdw/.local/bin:/home/fbwdw/.cargo/bin";
    XDG_DATA_DIRS = "$XDG_DATA_DIRS:/etc/profiles/per-user/fbwdw/bin:/run/current-system/sw";
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  programs.home-manager.enable = true;
  programs.zoxide.enable = true;
  programs.btop.enable = true;
}
