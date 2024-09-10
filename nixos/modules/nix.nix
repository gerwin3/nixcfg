{ pkgs, ... }:

{
  nix = {
    # FIXME: Use this version until the RCE in 2.24 is fixed then go back to
    # `nixVersions.latest`.
    package = pkgs.nixVersions.nix_2_23;

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
