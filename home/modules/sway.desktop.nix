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
      seat = {
        "*" = {
          xcursor_theme = "Adwaita 24";
        };
      };
      workspaceOutputAssign = [
        {
          workspace = "1";
          output = "DP-1";
        }
        {
          workspace = "2";
          output = "DP-1";
        }
        {
          workspace = "3";
          output = "DP-2";
        }
        {
          workspace = "4";
          output = "DP-2";
        }
        {
          workspace = "5";
          output = "DP-2";
        }
        {
          workspace = "6";
          output = "DP-2";
        }
        {
          workspace = "7";
          output = "DP-3";
        }
        {
          workspace = "8";
          output = "DP-3";
        }
        {
          workspace = "9";
          output = "DP-3";
        }
        {
          workspace = "10";
          output = "DP-3";
        }
      ];
    };
  };
}
