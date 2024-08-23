{ ... }:

{
  imports = [
    ./common.nix
    ./hardware/desktop-custom-Ryzen.nix
  ];

  networking.hostName = "gerwin-desktop";
}
