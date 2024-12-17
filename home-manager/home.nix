{ config, pkgs, lib, ... }:
let
  rrtui = import ./rrtui.nix { inherit pkgs; };
  colors = config.lib.stylix.colors;
in {
  imports = [
    ./discord.nix
    ./fish.nix
    ./fastfetch.nix
    ./nvim
    ./river
    ./tmux.nix
    ./waybar.nix
    ./yazi.nix
  ];

  home.username = "fbwdw";
  home.homeDirectory = "/home/fbwdw";

  home.stateVersion = "23.11";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (_: true);
  
  home.packages = with pkgs; [
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
    mpc-cli
    mpd-mpris
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
  programs.bat.enable = true;
  programs.zoxide.enable = true;
  programs.btop.enable = true;
  services.swaync.enable = true;

  services.mpd.enable = true;
  services.mpd-mpris.enable = true;
  services.mpd.musicDirectory = "${config.home.homeDirectory}/media/music/music";
  services.mpd.playlistDirectory = "${config.home.homeDirectory}/media/music/playlists";
  programs.ncmpcpp.enable = true;

  programs.foot.enable = true;
  programs.foot.settings.cursor.color = "${colors.base00} ${colors.base05}";
  programs.foot.settings.main = {
    term = "xterm-256color";
    letter-spacing = 0.25;
    pad = "5x0";
  };

  programs.bemenu.enable = true;
  programs.bemenu.settings = {
    list = 15;
    prompt = "open";
    ignorecase = true;
  };

  programs.zathura.enable = true; 
  programs.zathura.options.statusbar-home-tilde = true;
  programs.zathura.extraConfig = ''
    set selection-clipboard clipboard
    set incremental-search true
    set recolor true
  '';

  programs.starship.enable = true;
  programs.starship.settings = {
    format = ''[\($username@$hostname\)](blue bold) $directory$package$git_branch$git_status$git_state$character'';
    username.show_always = true;
    username.format = "$user";
    hostname.ssh_only = false;
    hostname.format = "$ssh_symbol$hostname";
    git_branch.format = "[$branch(:$remote_branch)]($style) ";
    add_newline = false;
  };
}
