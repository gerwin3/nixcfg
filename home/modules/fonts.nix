{ pkgs, ... }:

{
  home.packages =
    let
      berkeley-mono = (import ../../nixos/modules/berkeley-mono.nix) pkgs;
    in
    with pkgs; [
      fontconfig
      (nerdfonts.override { fonts = [ "Iosevka" ]; })
      berkeley-mono
    ];

  fonts.fontconfig.enable = true;

  gtk.font.name = "Iosevka Nerd Font 11";
}
