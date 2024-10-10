{ pkgs, ... }:

{
  fonts.packages =
    let
      berkeley-mono = (import ./berkeley-mono.nix) pkgs;
    in
    with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      (nerdfonts.override { fonts = [ "Iosevka" ]; })
      berkeley-mono
    ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ "Iosevka Nerd Font" "Noto Serif" ];
      sansSerif = [ "Iosevka Nerd Font" "Noto Sans" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
