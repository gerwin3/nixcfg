{ ... }:

{
  imports = [
    ./common.nix
    ./modules/brightness.nix
    ./hardware/apple-MacBook-Air-M2.nix
  ];

  networking.hostName = "gerwin-laptop";
}
