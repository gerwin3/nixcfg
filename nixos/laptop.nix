{ ... }:

{
  imports = [
    ./common.nix
    ./modules/brightness.nix
    ./modules/fingerprint.nix
    ./modules/fwupd.nix
    ./hardware/framework-13-Ryzen.nix
  ];

  networking.hostName = "gerwin-laptop";
}
