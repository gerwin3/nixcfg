{
  description = "gerwin nixcfg";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/e9a7a8adf9710005b0cdf95f81fb07b25c5f777d";
    flake-utils.url = "github:numtide/flake-utils/11707dc2f618dd54ca8739b309ec4fc024de578b";
    home-manager = {
      url = "github:nix-community/home-manager/1a95e2efb477959b70b4a14c51035975c0481df6";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/ef4efb84766a166c906bd55759574676bf91267c";
    impermanence = {
      url = "github:nix-community/impermanence/7b1d382faf603b6d264f58627330f9faa5cba149";
    };
    catppuccin.url = "github:catppuccin/nix/96bf46de3e35bc8e4e1040db43d57f21ae8648e2";
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
