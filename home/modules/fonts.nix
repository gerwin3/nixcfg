{ pkgs, ... }:

{
  home.packages = [
    pkgs.fontconfig
    (pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; })
  ];

  fonts.fontconfig.enable = true;

  gtk.font.name = "Iosevka Nerd Font 11";
}
