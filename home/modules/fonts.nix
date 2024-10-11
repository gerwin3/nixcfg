{ pkgs, ... }:

{
  home.packages =
    let
      berkeley-mono = (import ../../nixos/modules/berkeley-mono.nix) pkgs;
    in
    with pkgs; [
      fontconfig
      berkeley-mono
      inter
    ];

  fonts.fontconfig.enable = true;

  gtk.font.name = "Inter 11";
}
