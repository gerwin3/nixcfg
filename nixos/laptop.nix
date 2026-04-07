{ ... }:

{
  imports = [
    ./common.nix
    ./modules/fingerprint.nix
    ./modules/fwupd.nix
    ./modules/time.nix
    ./hardware/framework-13-Ryzen.nix
  ];

  networking.hostName = "gerwin-laptop";
}
