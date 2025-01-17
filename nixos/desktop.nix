{ ... }:

{
  imports = [
    ./common.nix
    ./modules/nvidia.nix
    ./modules/steam.nix
    ./modules/wireguard.desktop.nix
    ./hardware/desktop-custom-Ryzen.nix
  ];

  networking.hostName = "gerwin-desktop";
}
