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
              # TODO: Temporarily overlay sway and wlroots so we get the latest
              # master version which fixes the tearing issue, until Sway 1.10 is
              # released. Took this excellent overlay from here:
              # https://github.com/lovesegfault/nix-config/blob/c6bff2fde78b7b68d143bb78886e73b68b6eb0c0/nix/overlays/sway-unstable.nix
              (final: prev: {
                wlroots-unstable = (final.wlroots_0_17.overrideAttrs (old: {
                  version = "unstable-2024-08-13";
                  src = final.fetchFromGitLab {
                    domain = "gitlab.freedesktop.org";
                    owner = "wlroots";
                    repo = "wlroots";
                    rev = "2c64f36e8886d1f26daeb2a4ee79f3f9dd3d4c85";
                    hash = "sha256-elHu3d82STGB+pTGPj1K9eOyWGsotqUX4e0ZQ+db4Rg=";
                  };
                  buildInputs = (old.buildInputs or [ ]) ++ [
                    final.lcms2
                  ];
                })).override { };
                sway-unwrapped = (prev.sway-unwrapped.overrideAttrs (old: {
                  version = "unstable-2024-08-11";
                  src = final.fetchFromGitHub {
                    owner = "swaywm";
                    repo = "sway";
                    rev = "b44015578a3d53cdd9436850202d4405696c1f52";
                    hash = "sha256-gTsZWtvyEMMgR4vj7Ef+nb+wcXkwGivGfnhnBIfPHOA=";
                  };
                  nativeBuildInputs = with final; (old.nativeBuildInputs or [ ]) ++ [ bash-completion fish ];
                  mesonFlags = builtins.filter
                    (f: f != "-Dxwayland=enabled")
                    (old.mesonFlags or [ ]);
                })).override { wlroots = final.wlroots-unstable; };
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
