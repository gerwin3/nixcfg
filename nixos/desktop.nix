{ ... }:

{
  imports = [
    ./common.nix
    ./modules/autoupgrade.nix
    ./modules/nvidia.nix
    ./modules/steam.nix
    ./modules/tailscale.nix
    ./hardware/desktop-custom-Ryzen.nix
  ];

  networking.hostName = "gerwin-desktop";
}
