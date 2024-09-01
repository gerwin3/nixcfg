{ ... }:

{
  wayland.windowManager.sway = {
    config = {
      output = {
        "eDP-1".bg = "${../resources/background-horizontal.png} fill";
      };
    };
  };
}
