{ pkgs, lib, config, ... }: {
  services.mpd.enable = true;
  services.mpd-mpris.enable = true;
  services.mpd.musicDirectory = "${config.home.homeDirectory}/media/music/music";
  services.mpd.playlistDirectory = "${config.home.homeDirectory}/media/music/playlists";
  home.packages = with pkgs; [
    mpc-cli
    mpd-mpris
  ];
  programs.ncmpcpp.enable = true;
}
