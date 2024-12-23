{ config, pkgs, ... }:
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
    ./librewolf.nix
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
    foliate
    hevea
    (texlive.withPackages (ps: with ps; [
      scheme-basic latexmk etoolbox amsfonts amsmath hyperref geometry xetex
    ]))
    libinput
    lutris
    lldb
    mkpasswd
    mpc-cli
    mpd-mpris
    nix-prefetch-github
    nodejs_23
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
    waylock
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    yt-dlp
    zathura
    zoxide
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    GIT_EDITOR = "nvim";
    PATH = "$PATH:/home/fbwdw/.nix-profile/bin/:/home/fbwdw/.local/bin:/home/fbwdw/.cargo/bin:/home/fbwdw/.npm-packages/bin";
    XDG_DATA_DIRS = "$XDG_DATA_DIRS:/etc/profiles/per-user/fbwdw/bin:/run/current-system/sw";
  };

  programs = {
    direnv.enable = true;
    direnv.nix-direnv.enable = true;

    home-manager.enable = true;
    bemenu.enable = true;
    bat.enable = true;
    zoxide.enable = true;
    btop.enable = true;
    ncmpcpp.enable = true;

    foot.enable = true;
    foot.settings.cursor.color = "${colors.base00} ${colors.base05}";
    foot.settings.main = {
      term = "xterm-256color";
      letter-spacing = 0.25;
      pad = "5x2";
    };

    zathura.enable = true; 
    zathura.options = {
      statusbar-home-tilde = true;
      incremental-search = true;
      selection-clipboard = "clipboard";
      recolor = true;
    };

    starship.enable = true;
    starship.settings = {
      format = ''[\($username@$hostname\)](blue bold) $directory$package$git_branch$git_status$git_state$character'';
      username.show_always = true;
      username.format = "$user";
      hostname.ssh_only = false;
      hostname.format = "$ssh_symbol$hostname";
      git_branch.format = "[$branch(:$remote_branch)]($style) ";
      add_newline = false;
    };
  };

  services = {
    swaync.enable = true;
    mpd.enable = true;
    mpd-mpris.enable = true;
    mpd.musicDirectory = "${config.home.homeDirectory}/media/music/music";
    mpd.playlistDirectory = "${config.home.homeDirectory}/media/music/playlists";

    swayidle.enable = true;
    swayidle.timeouts = [
      {
        timeout = 30;
        command = ''
          ${pkgs.waylock}/bin/waylock
          --init-color ${colors.base00}
          --input-color ${colors.base03}
          --input-alt-color ${colors.base04}
          --fail-color ${colors.base08}
        '';
      }
      { timeout = 60; command = "${pkgs.systemd}/bin/systemctl suspend"; }
    ];
  };

  home.file.".npmrc".text = ''
    prefix = /home/fbwdw/.npm-packages
  '';
}
