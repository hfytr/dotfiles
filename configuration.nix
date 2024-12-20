{ inputs, config, pkgs, ... }:
{
  environment.variables = {
    XDG_RUNTIME_DIR = "/run/user/$UID";
  };

  imports = [ ./hardware-configuration.nix ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
    xkb.options = "compose:ralt";
  };

  # setup pipewire
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  services.blueman.enable = true;
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  users.users.fbwdw = {
    hashedPassword = "$6$ok5nScrid37eI81o$pqX1d9LqDoZYKMCr9VKnLh5MtY/F0zypq5E8oaSQ6meEaoAAwtB338TynnC1JYZHtulTph4xMYY/QG/BG14dj1";
    isNormalUser = true;
    description = "Archim Jhunjhunwala";
    extraGroups = [ "networkmanager" "wheel" "audio" "sound" "video" "input" "uinput" "tty" "dialout"];
  };

  security.sudo.extraRules = [{
    users = [ "fbwdw" ];
    commands = [{
      command = "ALL";
      options = [ "NOPASSWD" ];
    }];
  }];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.11";

  xdg.portal = {
    enable = true;
    config = {common = {default = "wlr";};};
    wlr.enable = true;
    wlr.settings.screencast = {
      output_name = "DP-2";
      chooser_type = "simple";
      chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
    };
  };

  # programs.hyprland.enable = true;
  programs.river.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet -r --time -c river";
        user = "fbwdw";
      };
    };
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    alsa-utils
    gcc
    git
    gnumake
    libsForQt5.qt5.qtgraphicaleffects
    fish
    wget
    curl
  ];
  # for Vial firmware
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
  ''; 

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip ];
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];
  stylix.enable = true;
  stylix.image = config.lib.stylix.pixel "base00";
  stylix.autoEnable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
  stylix.fonts.monospace = {
    package = pkgs.jetbrains-mono;
    name = "JetBrainsMono NFM";
  };
  stylix.fonts = {
    serif = config.stylix.fonts.monospace;
    sansSerif = config.stylix.fonts.monospace;
    emoji = config.stylix.fonts.monospace;
    sizes = {
      applications = 7;
      desktop = 7;
      popups = 7;
      terminal = 7;
    };
  };
}
