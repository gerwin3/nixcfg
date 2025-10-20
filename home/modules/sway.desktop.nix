{ lib, ... }:

{
  wayland.windowManager.sway = {
    config =
      let
        mod = "Mod4";
      in
      {
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
        # There is no reliable way to have the initial default layout be splitv
        # on specific workspaces. Instead, this hacky workaround overrides the
        # workspace bindings for 3, 4, 5 and 6 (the ones on the vertical
        # monitor) to change the layout to vertical when they are used. This
        # will reduce the number of times I have to do it manually when using
        # the vertical monitor.
        keybindings = {
          "${mod}+3" = lib.mkForce "workspace 3; layout splitv";
          "${mod}+4" = lib.mkForce "workspace 4; layout splitv";
          "${mod}+5" = lib.mkForce "workspace 5; layout splitv";
          "${mod}+6" = lib.mkForce "workspace 6; layout splitv";
        };
      };
  };
}
