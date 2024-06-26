{ inputs, config, pkgs, ... }:
{
  environment.variables = {
    XDG_RUNTIME_DIR = "/run/user/$UID";
  };

  imports = [
    ./hardware-configuration.nix
  ];


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
  sound.enable = true;
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
    extraGroups = [ "networkmanager" "wheel" "audio" "sound" "video" "input" "uinput" "tty"];
  };

  # disable sudo for fbwdw
  security.sudo.extraRules = [{
    users = [ "fbwdw" ];
    commands = [{
      command = "ALL";
      options = [ "NOPASSWD" ];
    }];
  }];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.11"; # Did you read the comment?

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  programs.hyprland.enable = true;
  services.displayManager.sddm = {
    enable = true;
    theme = "sugar-candy";
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    (callPackage ./sugar-candy.nix{}).sddm-sugar-candy-theme
    git
    gnumake
    libsForQt5.qt5.qtgraphicaleffects
    hyprland
    sddm
    fish
  ];

  # for Vial firmware
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
  ''; 
}
