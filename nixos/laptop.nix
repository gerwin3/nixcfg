{ ... }:

{
  imports = [
    ./common.nix
    ./modules/brightness.nix
    ./modules/fingerprint.nix
    ./modules/fwupd.nix
    # ./modules/wireguard.laptop.nix TODO
    ./hardware/framework-13-Ryzen.nix
  ];

  networking.hostName = "gerwin-laptop";
}
