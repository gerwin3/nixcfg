{ ... }:

{
  wayland.windowManager.sway = {
    config =
      let
        outputA = "Philips Consumer Electronics Company PHL 273V7 UK02206019245";
        outputB = "BNQ BenQ GW2780 L9K0136001Q";
      in
      {
        output = {
          "${outputA}" = {
            pos = "0 0";
            bg = "${../resources/background-horizontal.png} fill";
          };
          "${outputB}" = {
            pos = "1920 180";
            bg = "${../resources/background-horizontal.png} fill";
          };
        };
        seat = {
          "*" = {
            xcursor_theme = "Adwaita 32";
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
            output = outputA;
          }
          {
            workspace = "4";
            output = outputA;
          }
          {
            workspace = "5";
            output = outputA;
          }
          {
            workspace = "6";
            output = outputA;
          }
          {
            workspace = "7";
            output = outputA;
          }
          {
            workspace = "8";
            output = outputA;
          }
          {
            workspace = "9";
            output = outputB;
          }
          {
            workspace = "10";
            output = outputB;
          }
        ];
      };
  };
}
