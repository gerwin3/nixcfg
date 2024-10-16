{ ... }:

{
  wayland.windowManager.sway = {
    config = {
      output = {
        "DP-1" = {
          pos = "0 420";
          scale = "2";
          bg = "${../resources/background-horizontal.png} fill";
        };
        "DP-2" = {
          pos = "1920 0";
          scale = "2";
          transform = "270";
          bg = "${../resources/background-vertical.png} fill";
        };
        "DP-3" = {
          pos = "3000 440";
          scale = "2";
          bg = "${../resources/background-horizontal.png} fill";
        };
      };
      modes = {
        # Move mode allows switching to any workspace without having to reach
        # for the number keys. Activate move mode by pressing Mod+m, then the
        # mappings are:
        # * e, r -> 1, 2 (workspaces on monitor 1)
        # * a, s, d, f -> 3, 4, 5, 6 (workspaces on monitor 2)
        # * j, m, k, ; -> 7, 8, 9, 10 (workspaces on monitor 3)
        move = {
          "e" = "workspace 1; mode default";
          "r" = "workspace 2; mode default";
          "a" = "workspace 3; mode default";
          "s" = "workspace 4; mode default";
          "d" = "workspace 5; mode default";
          "f" = "workspace 6; mode default";
          "j" = "workspace 7; mode default";
          "k" = "workspace 8; mode default";
          "l" = "workspace 9; mode default";
          "Semicolon" = "workspace 10; mode default";
          "Escape" = "mode default";
        };
        # Take mode is the same as move mode but it takes the currently
        # selected window with it.
        take = {
          "e" = "move container to workspace 1; workspace 1; mode default";
          "r" = "move container to workspace 2; workspace 2; mode default";
          "a" = "move container to workspace 3; workspace 3; mode default";
          "s" = "move container to workspace 4; workspace 4; mode default";
          "d" = "move container to workspace 5; workspace 5; mode default";
          "f" = "move container to workspace 6; workspace 6; mode default";
          "j" = "move container to workspace 7; workspace 7; mode default";
          "k" = "move container to workspace 8; workspace 8; mode default";
          "l" = "move container to workspace 9; workspace 9; mode default";
          "Semicolon" = "move container to workspace 10; workspace 10; mode default";
          "Escape" = "mode default";
        };
      };
      seat = {
        "*" = {
          xcursor_theme = "Adwaita 24";
        };
      };
      workspaceOutputAssign = [
        { workspace = "1"; output = "DP-1"; }
        { workspace = "2"; output = "DP-1"; }
        { workspace = "3"; output = "DP-2"; }
        { workspace = "4"; output = "DP-2"; }
        { workspace = "5"; output = "DP-2"; }
        { workspace = "6"; output = "DP-2"; }
        { workspace = "7"; output = "DP-3"; }
        { workspace = "8"; output = "DP-3"; }
        { workspace = "9"; output = "DP-3"; }
        { workspace = "10"; output = "DP-3"; }
      ];
    };
  };
}
