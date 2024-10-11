{ pkgs, ... }:

{
  fonts.packages =
    let
      berkeley-mono = (import ./berkeley-mono.nix) pkgs;
    in
    with pkgs; [
      berkeley-mono
      inter
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
    ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ "Inter" "Noto Serif" ];
      sansSerif = [ "Inter" "Noto Sans" ];
      monospace = [ "BerkeleyMono Nerd Font" "Noto Mono" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
