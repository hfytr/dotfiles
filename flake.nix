{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.url = "github:catppuccin/nix";
    kmonad = {
      url = "git+https://github.com/kmonad/kmonad?submodules=1&dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, catppuccin, kmonad, ... }: {
    nixosConfigurations.fbwdwNixos =
      let
        system = "x86_64-linux";
        modules = [
          ./system/configuration.nix
          catppuccin.nixosModules.catppuccin
          kmonad.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.fbwdw = {
              imports = [
                ./system/home-manager/home.nix
                catppuccin.homeManagerModules.catppuccin
              ];
            };
            home-manager.backupFileExtension = "bak";
          }
        ];
      in nixpkgs.lib.nixosSystem {
        inherit system modules;
      };
  };
}
