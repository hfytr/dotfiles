{ inputs, config, pkgs, ... }:
let colors = config.lib.stylix.colors;
in {
  imports = [
    ./fish.nix
    ./foot.nix
    ./river.nix
    ./waybar.nix
    ./librewolf.nix
    ./nvim.nix
  ];

  home.username = "fbwdw";
  home.homeDirectory = "/home/fbwdw";

  home.stateVersion = "23.11";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (_: true);

  home.packages = with pkgs; [
    alsa-utils
    brave
    calibre
    dbus
    dnsmasq
    eza
    feh
    ffmpeg_7
    fzf
    git
    libinput
    localsend
    lutris
    man-pages
    man-pages-posix
    mpc
    mpd-mpris
    ncpamixer
    playerctl
    phodav
    qbittorrent
    slurp
    unzip
    update-nix-fetchgit
    vial
    virtiofsd
    vlc
    waylock
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    xournalpp
    zathura
    zoxide
    (texlive.withPackages (ps: with ps; [
      scheme-basic latexmk etoolbox amsfonts amsmath hyperref geometry xetex
      parskip ec titlesec marvosym collection-fontsrecommended changepage enumitem
    ]))
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

    ripgrep.enable = true;
    ripgrep.arguments = [ "--colors=line:fg:yellow" ];

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
      "ob" = "focus_inputbar ':open ~/docs/books/'";
      "om" = "focus_inputbar ':open /tmp/mozilla_fbwdw0/'";
      "oo" = "focus_inputbar ':open '";
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

    yazi.enable = true;
    yazi.enableFishIntegration = true;
    yazi.settings.mgr = {
      show_hidden = true;
      show_symlink = true;
      scrolloff = 10;
      linemode = "size";
    };
  };

  services = {
    mpd-mpris.enable = true;
    mpd = {
      enable = true;
      musicDirectory = "${config.home.homeDirectory}/media/music/music";
      playlistDirectory = "${config.home.homeDirectory}/media/music/playlists";
    };
    swaync.enable = true;
    swayidle = {
      enable = true;
      systemdTarget = "graphical-session.target";
      events = {
        "before-sleep" = "${pkgs.waylock}/bin/waylock -fork-on-lock";
      };
      extraArgs = [ "-w" ];
    };
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
}
