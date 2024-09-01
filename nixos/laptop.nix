{ ... }:

{
  imports = [
    ./common.nix
    ./modules/brightness.nix
    ./hardware/framework-13-Ryzen.nix
  ];

  networking.hostName = "gerwin-laptop";
}
