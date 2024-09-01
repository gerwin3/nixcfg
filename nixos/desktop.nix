{ ... }:

{
  imports = [
    ./common.nix
    ./modules/wireguard.desktop.nix
    ./hardware/desktop-custom-Ryzen.nix
  ];

  networking.hostName = "gerwin-desktop";
}
