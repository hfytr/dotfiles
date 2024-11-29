{ pkgs, config, lib, ... }:
let riverConf = pkgs.rustPlatform.buildRustPackage rec {
    pname = "riverConf";
    version = "0.1.0";
    src = pkgs.lib.cleanSource ./.;
    cargoLock.lockFile = ./Cargo.lock;
    cargoBuildOptions = [ "--release" ];
    buildPhase = ''
      cargo build --release
    '';
    installPhase = ''
      mkdir -p $out/bin
      cp target/release/riverConf $out/bin
    '';
  };
  colors = config.lib.stylix.colors;
in {
  home.packages = with pkgs; [
    hyprland
    hyprlock
    grim
    slurp
    swappy
    wl-clipboard-rs
    brightnessctl
    riverConf
  ];

  home.file.".config/river/silex-colors.txt".text = ''
    base00: ${colors.base00}
    base01: ${colors.base01}
    base02: ${colors.base02}
    base03: ${colors.base03}
    base04: ${colors.base04}
    base05: ${colors.base05}
    base06: ${colors.base06}
    base07: ${colors.base07}
    base08: ${colors.base08}
    base09: ${colors.base09}
    base0A: ${colors.base0A}
    base0B: ${colors.base0B}
    base0C: ${colors.base0C}
    base0D: ${colors.base0D}
    base0E: ${colors.base0E}
    base0F: ${colors.base0F}
  '';
  home.file.".config/river/init" = {
    text = ''
      dbus-update-activation-environment --all

      ps aux | rg 'wideriver' | awk '{print $2}' | xargs kill
      ps aux | rg 'waybar' | awk '{print $2}' | xargs kill

      nohup ${pkgs.wideriver}/bin/wideriver --layout wide --layout-alt left --ratio-master 0.6 --count-wide-left 0 --border-width 3 --border-color-focused 0x${colors.base05} --border-color-unfocused 0x${colors.base03} &
      nohup ${pkgs.waybar}/bin/waybar -c ~/.config/waybar/config -s ~/.config/waybar/style.css &      

      ${riverConf}/bin/riverConf
    '';
    executable = true;
  };
}
