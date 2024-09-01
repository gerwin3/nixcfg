{ ... }:

{
  wayland.windowManager.sway = {
    config = {
      output = {
        #      0000       1920     3000       4920
        #        │          │        │          │
        #        │          ▼        ▼          │
        # 0000   │          ┌────────┐          │
        #        ▼          │        │          ▼
        # 0450 ─►┌──────────┤        ├──────────┐
        #        │          │        │          │
        # 1080   │   DP-1   │  DP-2  │ HDMI-A-1 │
        #        │          │        │          │
        # 1680 ─►└──────────┤        ├──────────┘
        #                   │        │
        # 1920              └────────┘
        "DP-1" = {
          pos = "0 450";
          bg = "${../resources/background-horizontal.png} fill";
        };
        "DP-2" = {
          pos = "1920 0";
          transform = "90";
          bg = "${../resources/background-vertical.png} fill";
        };
        "HDMI-A-1" = {
          pos = "3000 420";
          bg = "${../resources/background-horizontal.png} fill";
        };
      };
      workspaceOutputAssign = [
        { workspace = "1"; output = "DP-1"; }
        { workspace = "2"; output = "DP-1"; }
        { workspace = "3"; output = "DP-2"; }
        { workspace = "4"; output = "DP-2"; }
        { workspace = "5"; output = "DP-2"; }
        { workspace = "6"; output = "DP-2"; }
        { workspace = "7"; output = "HDMI-A-1"; }
        { workspace = "8"; output = "HDMI-A-1"; }
        { workspace = "9"; output = "HDMI-A-1"; }
        { workspace = "10"; output = "HDMI-A-1"; }
      ];
    };
  };
}
