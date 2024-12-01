{ pkgs, config, lib, ... }:
let colors = config.lib.stylix.colors.withHashtag;
in {
  stylix.targets.waybar.enable = false; # 
  programs.waybar.enable = true;
  programs.waybar.settings.mainBar = {
    layer = "top";
    position = "left";
    margin-top = 0;
    margin-bottom = 0;
    margin-left = 0;
    margin-right = 0;
    spacing = 0;
    gtk-layer-shell = false;

    modules-left = [ "clock" ];
    modules-center = [
      "river/tags"
      # "river/layout"
    ];
    modules-right = [
      "cpu"
      "memory"
      "backlight"
      "pulseaudio#audio"
      "battery"
    ];

    "clock" = {
      interval = 1;
      justify = "center";
      format = "\n{:%I\n%M\n%p\n\n󰃭\n%d\n%m\n%y}";
      tooltip = true;
      tooltip-format = "{calendar}";
      calendar = {
        mode = "year";
        mode-mon-col = 3;
        format = {
          today = "<span color='#0dbc79'>{}</span>";
        };
      };
    };

    "river/tags" = { num-tags = 10; };
    # "river/layout" = { format = "{}"; };

    "cpu" = {
      format = "CPU\n{usage}%";
      justify = "center";
      on-click = "";
      tooltip = false;
    };

    "memory" = {
      format = "RAM\n{percentage}%\n\nSWAP\n{swapPercentage}%";
      interval = 10;
      justify = "center";
      on-click = "";
      tooltip = false;
    };

    "backlight" = {
      format = "󰃠\n{percent}%";
      justify = "center";
      on-scroll-up = "brightnessctl set +5% && ~/.config/dunst/scripts/show_brightness.sh";
      on-scroll-down = "brightnessctl set 5%- && ~/.config/dunst/scripts/show_brightness.sh";
      on-click = "";
      tooltip = false;
    };

    "pulseaudio#audio" = {
      format = "{icon}\n{volume}%";
      justify = "center";
      format-bluetooth = "󰂯 {icon}\n{volume}%";
      format-bluetooth-muted = "󰂯 󰖁";
      format-muted = "󰖁";
      format-icons = {
        headphone = "󰋋";
        hands-free = "󰋋";
        headset = "󰋋";
        phone = "";
        portable = "";
        car = "";
        default = [ "󰕿" "󰖀" "󰕾" ];
      };
      on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle && ~/.config/dunst/scripts/show_mute.sh";
      on-scroll-up = "pactl set-sink-volume @DEFAULT_SINK@ +1% && ~/.config/dunst/scripts/show_volume.sh";
      on-scroll-down = "pactl set-sink-volume @DEFAULT_SINK@ -1% && ~/.config/dunst/scripts/show_volume.sh";
      tooltip = true;
      tooltip-format = "{icon} {desc} {volume}%";
    };

    "battery" = {
      states = {
        warning = 20;
        critical = 5;
      };
      interval = 5;
      justify = "center";
      format = "{icon}\n{capacity}%";
      format-charging = "󰂄\n{capacity}%";
      format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
      on-click = "";
      tooltip = true;
      tooltip-format = "{timeTo}";
    };
  };

  programs.waybar.style = ''
    @define-color background ${colors.base00};
    @define-color foreground ${colors.base05};
    @define-color dull ${colors.base03};

    * {
      font-family: "JetBrains Mono NFM";
      font-size: 10px;
    }

    window#waybar {
      background-color: @background;
      color: @foreground;
    }

    tooltip {
      background: @background;
      border: 1px solid @foreground;
    }
    tooltip label {
      color: @foreground;
    }

    #tags button {
      background-color: transparent;
      color: @dull;
      padding: 1px 2px;
      margin: 3px 3px;
      transition: all 0.3s ease;
    }

    #tags button:hover {
      box-shadow: inherit;
      text-shadow: inherit;
      background: transparent;
      transition: all 0.3s ease;
      color: @foreground;
    }

    #tags button.focused,
    #tags button.active {
      color: @foreground;
      transition: all 0.3s ease;
      animation: colored-gradient 10s ease infinite;
    }

    #tags button.urgent {
      background-color: @foreground;
      color: @background;
      transition: all 0.3s ease;
    }

    #mode,
    #tray,
    #cpu,
    #memory,
    #backlight,
    #pulseaudio.audio,
    #network,
    #bluetooth,
    #battery,
    #clock {
      background-color: transparent;
      color: @foreground;
      padding: 1px 6px;
      margin-top: 3px;
      margin-bottom: 3px;
      margin-left: 1px;
      margin-right: 1px;
      border-radius: 20px;
      transition: all 0.3s ease;
    }

    #clock { margin-top: 10px; }
    #battery { margin-bottom: 10px; }
  '';
}
