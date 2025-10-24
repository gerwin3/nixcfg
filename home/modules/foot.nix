{ variant, ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font =
          if variant == "laptop" then "BerkeleyMono Nerd Font:size=10" else "BerkeleyMono Nerd Font:size=9";
        pad = "8x8";
        # Had this enable previously because it causes foot to copy stuff into
        # the clipboard correctly. Unfortunately, it also breaks copying stuff
        # into foot for some unknown reason. So don't enable it!
        # selection-target = "both";
        term = "xterm-256color";
      };

      key-bindings = {
        search-start = "Control+Shift+f";
        scrollback-up-half-page = "Control+Shift+k";
        scrollback-down-half-page = "Control+Shift+j";
      };

      search-bindings = {
        find-prev = "Shift+Tab";
        find-next = "Tab";
      };
    };
  };

  home.sessionVariables.TERMINAL = "foot";
}
