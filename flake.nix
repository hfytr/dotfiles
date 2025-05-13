{
  description = "NixOS configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
  };

  outputs = inputs@{nixpkgs, home-manager, stylix, ... }: {
    nixosConfigurations.fbwdwNixos =
      let
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager {
            home-manager.useUserPackages = true;
            home-manager.users.fbwdw = {
              imports = [ ./home-manager/home.nix ];
            };
          }
        ];
      in nixpkgs.lib.nixosSystem {
        inherit system modules;
      };
  };
}
