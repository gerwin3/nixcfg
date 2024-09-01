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
      modes = {
        # Move mode allows switching to any workspace without having to reach
        # for the number keys. Activate move mode by pressing Mod+m.
        move = {
          "a" = "workspace 1; mode default";
          "s" = "workspace 2; mode default";
          "d" = "workspace 3; mode default";
          "f" = "workspace 4; mode default";
          "g" = "workspace 5; mode default";
          "h" = "workspace 6; mode default";
          "j" = "workspace 7; mode default";
          "k" = "workspace 8; mode default";
          "l" = "workspace 9; mode default";
          "Semicolon" = "workspace 10; mode default";
          "Escape" = "mode default";
        };
        # Take mode is the same as move mode but it takes the currently
        # selected window with it.
        take = {
          "a" = "move container to workspace 1; workspace 1; mode default";
          "s" = "move container to workspace 2; workspace 2; mode default";
          "d" = "move container to workspace 3; workspace 3; mode default";
          "f" = "move container to workspace 4; workspace 4; mode default";
          "g" = "move container to workspace 5; workspace 5; mode default";
          "h" = "move container to workspace 6; workspace 6; mode default";
          "j" = "move container to workspace 7; workspace 7; mode default";
          "k" = "move container to workspace 8; workspace 8; mode default";
          "l" = "move container to workspace 9; workspace 9; mode default";
          "Semicolon" = "move container to workspace 10; workspace 10; mode default";
          "Escape" = "mode default";
        };
      };
    };
  };
}
