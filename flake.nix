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
            {
              nixpkgs.overlays = [
                inputs.nur.overlay
                # TODO: Temporarily overlay sway and wlroots so we get the latest
                # master version which fixes the tearing issue, until Sway 1.10 is
                # released. Took this excellent overlay from here:
                # https://github.com/lovesegfault/nix-config/blob/c6bff2fde78b7b68d143bb78886e73b68b6eb0c0/nix/overlays/sway-unstable.nix
                (final: prev: {
                  wlroots-unstable =
                    (final.wlroots_0_17.overrideAttrs (old: {
                      version = "unstable-2024-20-24";
                      src = final.fetchFromGitLab {
                        domain = "gitlab.freedesktop.org";
                        owner = "wlroots";
                        repo = "wlroots";
                        rev = "da8f7a07ba8c0767ffca134f871339cc475d5839";
                        hash = "sha256-zBRb+XGpCJJawhoZxDxzIKj9fmWimjDsUD1kQIfSe2s=";
                      };
                      buildInputs = (old.buildInputs or [ ]) ++ [
                        final.lcms2
                      ];
                    })).override
                      { };
                  sway-unwrapped =
                    (prev.sway-unwrapped.overrideAttrs (old: {
                      version = "unstable-2024-20-24";
                      src = final.fetchFromGitHub {
                        owner = "swaywm";
                        repo = "sway";
                        rev = "a63027245a6805bb952e47c5751ecdd7d1063d2f";
                        hash = "sha256-CZS0IgN8aKJw66l1kjEvRY9HL6LHJdGTTbyKgRfGNdo=";
                      };
                      nativeBuildInputs =
                        with final;
                        (old.nativeBuildInputs or [ ])
                        ++ [
                          bash-completion
                          fish
                        ];
                      mesonFlags = builtins.filter (f: f != "-Dxwayland=enabled") (old.mesonFlags or [ ]);
                    })).override
                      { wlroots = final.wlroots-unstable; };
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
          specialArgs = {
            inherit inputs;
          };
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
