{ ... }:

{
  imports = [
    ./common.nix
    ./modules/autoupgrade.nix
    ./modules/nvidia.nix
    ./modules/steam.nix
    ./hardware/desktop-custom-Ryzen-9.nix
  ];

  networking.hostName = "gerwin-desktop";
}
