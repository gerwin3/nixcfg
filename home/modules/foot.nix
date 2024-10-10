{ variant, ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = if variant == "laptop" then "Berkeley Mono:size=10" else "Berkeley Mono:size=9";
        pad = "8x8";
        # Had this enable previously because it causes foot to copy stuff into
        # the clipboard correctly. Unfortunately, it also breaks copying stuff
        # into foot for some unknown reason. So don't enable it!
        # selection-target = "both";
        term = "xterm-256color";
      };
    };
    catppuccin.enable = true;
  };
}
