{ pkgs, lib, ... }: {
  programs.fastfetch.enable = true;
  programs.fastfetch.settings = {
    display = {
        separator = "➤   ";
        color = {
            separator = "cyan";
        };
    };
    modules = [
        "break"
        {
            key = "  ╭─  OS           ";
            keyColor = "red";
            os = "nixos";
            type = "os";
        }
        {
            key = "  ├─  Kernel       ";
            keyColor = "red";
            type = "kernel";
        }
        {
            key = "  ├─  WM           ";
            keyColor = "red";
            type = "wm";
        }
        {
            key = "  ├─  DE           ";
            keyColor = "red";
            type = "de";
        }
        {
            key = "  ├─  Terminal     ";
            keyColor = "red";
            type = "terminal";
        }
        {
            key = "  ╰─  Shell        ";
            keyColor = "red";
            type = "shell";
        }
        {
            key = "  ╭─ 󰍛 Disk         ";
            keyColor = "magenta";
            type = "disk";
        }
        {
            key = "  ├─ 󰍹 Display      ";
            keyColor = "magenta";
            type = "display";
        }
        {
            key = "  ├─ 󰅐 Uptime       ";
            keyColor = "magenta";
            type = "uptime";
        }
        {
            key = "  ╰─ 󰑭 Memory       ";
            keyColor = "magenta";
            type = "memory";
        }
        "break"
        {
            type = "colors";
            paddingLeft = 24;
            symbol = "circle";
        }
    ];
  };
}
