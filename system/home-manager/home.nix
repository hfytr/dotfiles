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
    ./ranger
    ./discord
    ./firefox
    ./hypr
    ./waybar
    ./kitty
    ./rofi
    ./wal
    ./zathura
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
    dbus
    eza
    git
    feh
    ffmpeg_7
    fzf
    hevea
    imagemagick
    jq
    killall
    texliveMedium
    libinput
    lutris
    lldb
    mkpasswd
    nsxiv
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
    ueberzugpp
    unzip
    vial
    vlc
    webtorrent_desktop
    xdg-desktop-portal-hyprland
    yt-dlp
    zathura
    zoxide
  ];

  home.pointerCursor = {
    package = pkgs.rose-pine-cursor;
    name = "rose-pine-cursor";
    size = 32;
  };

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
  programs.zoxide.enable = true;
  programs.btop.enable = true;
  catppuccin.flavor = "mocha";
  catppuccin.enable = true;
}
