{ pkgs, config, lib, ... }:
let colors = config.lib.stylix.colors;
    pow = base: exp:
      let pow' = b: e:
        if e <= 0 then 1
        else b * pow' b (e - 1);
      in pow' base exp;
    powStr = base: exp: builtins.toString (pow base exp);
    tag_keys = [
      { key = "N"; tag = powStr 2 0; }
      { key = "R"; tag = powStr 2 1; }
      { key = "T"; tag = powStr 2 2; }
      { key = "S"; tag = powStr 2 3; }
      { key = "Q"; tag = powStr 2 4; }
      { key = "M"; tag = powStr 2 5; }
      { key = "W"; tag = powStr 2 6; }
      { key = "L"; tag = powStr 2 7; }
      { key = "D"; tag = powStr 2 8; }
      { key = "C"; tag = powStr 2 9; }
      { key = "G"; tag = powStr 2 10; }
    ];
in {
  home.packages = with pkgs; [
    grim
    slurp
    swappy
    wl-clipboard-rs
    brightnessctl
  ];

  wayland.windowManager.river.enable = true;
  wayland.windowManager.river.xwayland.enable = true;
  wayland.windowManager.river.settings = {
    keyboard-layout = "us";
    default-layout = "wideriver";
    focus-follows-cursor = "always";
    hide-cursor = {
      timeout = "10000";
      when-typing = "enabled";
    };
    set-cursor-warp = "on-focus-change";
    background-color = "0x${colors.base00}";
    rule-add = [
      "ssd"
      "-app-id waybar csd"
      "-app-id discord tags ${powStr 2 6}"
    ];
    map.normal = {
      "Super Q" = "close";
      "Super L" = "spawn waylock ";
      "Super V" = "toggle-float";
      "Super M" = "toggle-fullscreen";
      "Super Y" = "send-layout-cmd wideriver '--ratio -0.07'";
      "Super E" = "send-layout-cmd wideriver '--ratio +0.07'";
      "Super H" = "send-layout-cmd wideriver '--count -1'";
      "Super A" = "send-layout-cmd wideriver '--count +1'";
      "Alt Return" = "send-layout-cmd wideriver '--layout-toggle'";
      "Alt Tab" = "focus-previous-tags";
      "Super Z" = "zoom";
      "Super P" = "set-view-tags ${builtins.toString (pow 2 32 - 1)}";

      "None XF86MonBrightnessUp" = "spawn 'brightnessctl set +10%'";
      "None XF86MonBrightnessDown" = "spawn 'brightnessctl set 10%-'";
      "None XF86AudioMute" = "spawn 'amixer set Master toggle'";
      "None XF86AudioRaiseVolume" = "spawn 'amixer set Master 5%+ | amixer set Master on'";
      "None XF86AudioLowerVolume" = "spawn 'amixer set Master 5%- | amixer set Master on'";


      "Alt Space" = "focus-output next";
      "Super Space" = "send-to-output next";
      "Alt P" = "spawn 'playerctl play-pause'";
      "Super T" = "spawn foot";
      "Super B" = "spawn librewolf";
      "Shift+Super B" = "spawn 'librewolf --private-window https://xkcd.com'";
      "None Print" = "spawn 'grim -g \"$(slurp)\" $HOME/media/screenshots/$(date +'%s_grim.png')'";
      "Super Return" = lib.concatStringsSep " " [
         "spawn \"bemenu-run"
         "--tb '#${colors.base01}' --nb  '#${colors.base01}'"
         "--fb '#${colors.base01}' --hb  '#${colors.base03}'"
         "--sb '#${colors.base03}' --scb '#${colors.base01}'"
         "--hf '#${colors.base10}' --sf  '#${colors.base11}'"
         "--tf '#${colors.base05}' --ff  '#${colors.base05}'"
         "--nf '#${colors.base05}' --scf '#${colors.base03}'"
         "--ab '#${colors.base01}' --af '#${colors.base05}'"
         "--fn 'JetBrainsMono NFM Thin 7'"
         "-i -w -l 15 -p 'open'\"" ];
      "Alt Y" = "focus-view left";
      "Alt H" = "focus-view down";
      "Alt A" = "focus-view up";
      "Alt E" = "focus-view right";
      "Alt Up" = "focus-view next";
      "Alt Down" = "focus-view previous";
    }
    // (lib.lists.foldr
      (tag_key: acc: acc // {
        "Alt ${tag_key.key}" = "toggle-focused-tags ${tag_key.tag}";
        "Alt+Control ${tag_key.key}" = "set-focused-tags ${tag_key.tag}";
        "Super+Alt ${tag_key.key}" = "toggle-view-tags ${tag_key.tag}";
        "Super+Shift ${tag_key.key}" = "set-view-tags ${tag_key.tag}";
      }) {} tag_keys);
  };
  wayland.windowManager.river.extraConfig = ''
      riverctl input touch-1267-16773-ELAN9004:00_04F3:4185 map-to-output eDP-1

      dbus-update-activation-environment --all

      ps aux | rg 'wideriver' | awk '{print $2}' | xargs kill
      ps aux | rg 'waybar' | awk '{print $2}' | xargs kill

      nohup ${pkgs.wideriver}/bin/wideriver --layout wide --layout-alt monocle --border-width-monocle 3 --border-width 3 --border-color-focused 0x${colors.base05} --border-color-unfocused 0x${colors.base00} &
      nohup ${pkgs.waybar}/bin/waybar -c ~/.config/waybar/config -s ~/.config/waybar/style.css &
  '';
}
