{ ... }:

{
  wayland.windowManager.sway = {
    config = {
      input = {
        "2362:628:PIXA3854:00_093A:0274_Touchpad" = {
          natural_scroll = "enabled";
          tap = "enable";
        };
      };
      output = {
        "eDP-1".bg = "${../resources/background-horizontal.png} fill";
      };
      seat = {
        "*" = {
          xcursor_theme = "Adwaita 24";
        };
      };
    };
  };

  # TODO: This does not work at the moment on my framework for some reason.
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "swaylock";
      }
    ];
  };
}
