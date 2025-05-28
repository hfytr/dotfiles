{ inputs, config, pkgs, ... }:
let colors = config.lib.stylix.colors;
in {
  imports = [
    ./fastfetch.nix
    ./fish.nix
    ./foot.nix
    ./nvim
    ./river.nix
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
    brave
    calibre
    dbus
    eza
    git
    feh
    ffmpeg_7
    fzf
    (texlive.withPackages (ps: with ps; [
      scheme-basic latexmk etoolbox amsfonts amsmath hyperref geometry xetex
      parskip ec latexindent titlesec marvosym
    ]))
    libinput
    lutris
    ncpamixer
    mpc-cli
    mpd-mpris
    # openconnect
    playerctl
    pokeget-rs
    slurp
    unzip
    vial
    # vpnc
    # vpnc-scripts
    vlc
    waylock
    qbittorrent
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    yt-dlp
    zathura
    zoxide
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    GIT_EDITOR = "nvim";
    XDG_DATA_DIRS = "$XDG_DATA_DIRS:/etc/profiles/per-user/fbwdw/bin:/run/current-system/sw";
    PATH = "$PATH:/home/fbwdw/.local/bin";
  };

  home.file.".local/bin/kindle-share".text = ''
    #!${pkgs.bash}/bin/bash
    mkdir -p /mnt/kindle
    declare -i i=2
    mkdir -p /mnt/kindle/
    mount "/dev/$1"
    shift
    for var in "$@"
    do
      noext="$\{var%.*}"
      if [ "$noext.azw3" != "$var" ]
      then
        echo "CONVERTING $var to $noext.azw3"
        ebook-convert "$var" "$noext.azw3" 
      fi
      echo "$noext"
      cp "$noext.azw3" "/mnt/kindle/documents/Downloads/$noext.azw3"
    done
  '';
  home.file.".local/bin/kindle-share".executable = true;

  programs = {
    direnv.enable = true;
    direnv.nix-direnv.enable = true;

    home-manager.enable = true;
    bemenu.enable = true;
    zoxide.enable = true;
    ncmpcpp.enable = true;

    zathura.enable = true; 
    zathura.options = {
      statusbar-home-tilde = true;
      incremental-search = true;
      selection-clipboard = "clipboard";
      recolor = true;
    };
    zathura.mappings = {
      "od" = "focus_inputbar ':open ~/Downloads/'";
      "om" = "focus_inputbar ':open /tmp/mozilla_fbwdw0/'";
      "ob" = "focus_inputbar ':open ~/docs/school/books/'";
      "oo" = "focus_inputbar ':open'";
    };
    zathura.extraConfig = ''
      unmap o
    '';

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
  };
}
