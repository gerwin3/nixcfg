{
  description = "gerwin nixcfg";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/3c87485efdac5778710383c5fa9d36bf45f94544";
    flake-utils.url = "github:numtide/flake-utils/11707dc2f618dd54ca8739b309ec4fc024de578b";
    home-manager = {
      url = "github:nix-community/home-manager/8aec76cc1e045f37b55d82ca3cee4910ae04d3db";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/";
    impermanence = {
      url = "github:nix-community/impermanence/7b1d382faf603b6d264f58627330f9faa5cba149";
    };
    catppuccin.url = "github:catppuccin/nix/036c78ea4cd8a42c8546c6316a944fd7d59d4341";
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    {
      nixosConfigurations = {

        "gerwin-desktop" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./nixos/desktop.nix
            inputs.impermanence.nixosModules.impermanence
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.gerwin.imports = [
                ./home
                inputs.catppuccin.homeModules.catppuccin
              ];
              home-manager.extraSpecialArgs = {
                inherit inputs;
                variant = "desktop";
              };
            }
          ];
        };

        "gerwin-laptop" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./nixos/laptop.nix
            inputs.impermanence.nixosModules.impermanence
            inputs.home-manager.nixosModules.home-manager
            inputs.nixos-hardware.nixosModules.framework-13-7040-amd
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.gerwin.imports = [
                ./home
                inputs.catppuccin.homeModules.catppuccin
              ];
              home-manager.extraSpecialArgs = {
                inherit inputs;
                variant = "laptop";
              };
            }
          ];
        };

      };
    };
}
