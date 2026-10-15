{ ... }:

{
  wayland.windowManager.sway = {
    config = {
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
    events = {
      "before-sleep" = "swaylock";
    };
  };
}
