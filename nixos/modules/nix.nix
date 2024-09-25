{ pkgs, ... }:

{
  nix = {
    package = pkgs.nixVersions.latest;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "gerwin" ];
    };
  };

  nixpkgs.config.allowUnfree = true;
}
