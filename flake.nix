{
  description = "gerwin nixcfg";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/baf8c995700c5140135b3e7da60d7b03d98b7fe9";
    flake-utils.url = "github:numtide/flake-utils/11707dc2f618dd54ca8739b309ec4fc024de578b";
    home-manager = {
      url = "github:nix-community/home-manager/486595d2cf49cfcd649b58a284fa11ac0e34da22";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/6358ff76821101c178e3ab4919a62799bfe3652e";
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
