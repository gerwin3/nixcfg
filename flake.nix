{
  description = "gerwin nixcfg";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/85d9ad302c885bb3bd82d7d53f741462c7b48490";
    flake-utils.url = "github:numtide/flake-utils/11707dc2f618dd54ca8739b309ec4fc024de578b";
    home-manager = {
      url = "github:nix-community/home-manager/aa23f720d022187228bc264f759aef6b80233bcf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/31cc5f4d9b9ba601071e8b8504601b9b176e2756";
    impermanence = {
      url = "github:nix-community/impermanence/7b1d382faf603b6d264f58627330f9faa5cba149";
    };
    catppuccin.url = "github:catppuccin/nix/0c0335a1a6d326adb5a5e116aae0d51c7041b2e5";
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

        "gerwin-desktop-home" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./nixos/desktop-home.nix
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
                variant = "desktop-home";
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
