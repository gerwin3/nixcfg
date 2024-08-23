{ ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Iosevka Nerd Font:size=12";
        dpi-aware = "yes";
        pad = "8x8";
        term = "xterm-256color";
      };
    };
    catppuccin.enable = true;
  };
}
