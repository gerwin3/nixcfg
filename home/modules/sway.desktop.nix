{ lib, ... }:

{
  wayland.windowManager.sway = {
    config =
      let
        mod = "Mod4";
        outputA = "Philips Consumer Electronics Company 27E1N1800A UK02416016738";
        outputB = "Philips Consumer Electronics Company 27E1N1800A UK02416016744";
        outputC = "Philips Consumer Electronics Company 27E1N1800A UK02416016773";
      in
      {
        output = {
          "${outputA}" = {
            pos = "0 420";
            scale = "2";
            bg = "${../resources/background-horizontal.png} fill";
          };
          "${outputB}" = {
            pos = "1920 0";
            scale = "2";
            transform = "270";
            bg = "${../resources/background-vertical.png} fill";
          };
          "${outputC}" = {
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
            output = outputA;
          }
          {
            workspace = "2";
            output = outputA;
          }
          {
            workspace = "3";
            output = outputB;
          }
          {
            workspace = "4";
            output = outputB;
          }
          {
            workspace = "5";
            output = outputB;
          }
          {
            workspace = "6";
            output = outputB;
          }
          {
            workspace = "7";
            output = outputC;
          }
          {
            workspace = "8";
            output = outputC;
          }
          {
            workspace = "9";
            output = outputC;
          }
          {
            workspace = "10";
            output = outputC;
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
