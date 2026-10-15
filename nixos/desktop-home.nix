{ ... }:

{
  imports = [
    ./common.nix
    ./modules/nvidia.nix
    ./modules/steam.nix
    ./hardware/desktop-custom-Ryzen.nix
  ];

  networking.hostName = "gerwin-desktop-home";
}
