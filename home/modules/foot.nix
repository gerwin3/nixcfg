{ variant, ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = if variant == "laptop" then "Iosevka Nerd Font:size=11" else "Iosevka Nerd Font:size=10";
        pad = "8x8";
        term = "xterm-256color";
      };
    };
    catppuccin.enable = true;
  };
}
