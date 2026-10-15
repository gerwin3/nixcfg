{ ... }:

{
  wayland.windowManager.sway = {
    config = {
      output = {
        "HDMI-A-1".bg = "${../resources/background-horizontal.png} fill";
      };
      seat = {
        "*" = {
          xcursor_theme = "Adwaita 24";
        };
      };
    };
  };
}
