{
  description = "gerwin nixcfg";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    impermanence = {
      url = "github:nix-community/impermanence";
    };
    nur.url = "github:nix-community/nur"; # Used for Firefox extensions.
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {

      "gerwin-desktop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          {
            nixpkgs.overlays = [
              inputs.nur.overlay
              # FIXME: Overlay sway so we get the latest master version which
              # fixes the tearing issue.
              (self: super: {
                sway = super.sway.overrideAttrs (old: {
                  src = builtins.fetchGit {
                    url = "https://github.com/swaywm/sway.git";
                    rev = "7f1cd0b73ba3290f8ee5f81fdf7f1ffa4c642ea7";
                  };
                });
              })
            ];
          }
          ./nixos/desktop.nix
          inputs.impermanence.nixosModules.impermanence
          inputs.home-manager.nixosModules.home-manager
          inputs.catppuccin.nixosModules.catppuccin
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.gerwin.imports = [
              ./home
              inputs.catppuccin.homeManagerModules.catppuccin
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
        specialArgs = { inherit inputs; };
        modules = [
          { nixpkgs.overlays = [ inputs.nur.overlay ]; }
          ./nixos/laptop.nix
          inputs.impermanence.nixosModules.impermanence
          inputs.home-manager.nixosModules.home-manager
          inputs.nixos-hardware.nixosModules.framework-13-7040-amd
          inputs.catppuccin.nixosModules.catppuccin
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.gerwin.imports = [
              ./home
              inputs.catppuccin.homeManagerModules.catppuccin
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
