{ pkgs, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    config =
      let
        mod = "Mod4";
        workspaces = {
          ws1 = "1";
          ws2 = "2";
          ws3 = "3";
          ws4 = "4";
          ws5 = "5";
          ws6 = "6";
          ws7 = "7";
          ws8 = "8";
          ws9 = "9";
          ws10 = "10";
        };
        outputs = {
          mon1 = "DP-1";
          mon2 = "DP-2";
          mon3 = "HDMI-A-1";
        };
      in
      {
        modifier = mod;
        fonts = {
          names = [ "Iosevka Nerd Font" ];
          size = 14.0;
        };
        bars = [{ command = "waybar"; }];
        input = {
          "*" = {
            repeat_rate = "25";
            repeat_delay = "200";
            xkb_numlock = "enabled";
          };
        };
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
        keybindings = {
          # -- General --

          "${mod}+Shift+r" = "exec swaymsg restart";
          "${mod}+Shift+e" = "exec swaymsg exit";

          # -- Applications --

          "${mod}+Return" = "exec --no-startup-id foot";
          "${mod}+Shift+Return" = "exec --no-startup-id firefox";
          "${mod}+s" = "exec --no-startup-id grim -g \"$(slurp)\" - | wl-copy";
          "${mod}+Space" = "exec --no-startup-id bemenu-run";
          "${mod}+Escape" = "exec --no-startup-id swaylock";

          # -- Navigation --

          "${mod}+a" = "focus parent";
          "${mod}+e" = "layout toggle split";
          "${mod}+f" = "fullscreen toggle";
          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";
          "${mod}+n" = "workspace next_on_output";
          "${mod}+p" = "workspace prev_on_output";
          "${mod}+u" = "split h";
          "${mod}+v" = "split v";
          "${mod}+w" = "layout tabbed";

          "${mod}+1" = "workspace ${workspaces.ws1}";
          "${mod}+2" = "workspace ${workspaces.ws2}";
          "${mod}+3" = "workspace ${workspaces.ws3}";
          "${mod}+4" = "workspace ${workspaces.ws4}";
          "${mod}+5" = "workspace ${workspaces.ws5}";
          "${mod}+6" = "workspace ${workspaces.ws6}";
          "${mod}+7" = "workspace ${workspaces.ws7}";
          "${mod}+8" = "workspace ${workspaces.ws8}";
          "${mod}+9" = "workspace ${workspaces.ws9}";
          "${mod}+0" = "workspace ${workspaces.ws10}";

          "${mod}+Ctrl+h" = "resize shrink width 10 px or 10 ppt";
          "${mod}+Ctrl+j" = "resize grow height 10 px or 10 ppt";
          "${mod}+Ctrl+k" = "resize shrink height 10 px or 10 ppt";
          "${mod}+Ctrl+l" = "resize grow width 10 px or 10 ppt";
          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+l" = "move right";
          "${mod}+Shift+q" = "kill";
          "${mod}+Shift+space" = "floating toggle";

          "${mod}+Shift+1" = "move container to workspace ${workspaces.ws1}";
          "${mod}+Shift+2" = "move container to workspace ${workspaces.ws2}";
          "${mod}+Shift+3" = "move container to workspace ${workspaces.ws3}";
          "${mod}+Shift+4" = "move container to workspace ${workspaces.ws4}";
          "${mod}+Shift+5" = "move container to workspace ${workspaces.ws5}";
          "${mod}+Shift+6" = "move container to workspace ${workspaces.ws6}";
          "${mod}+Shift+7" = "move container to workspace ${workspaces.ws7}";
          "${mod}+Shift+8" = "move container to workspace ${workspaces.ws8}";
          "${mod}+Shift+9" = "move container to workspace ${workspaces.ws9}";
          "${mod}+Shift+0" = "move container to workspace ${workspaces.ws10}";

          # -- Hardware keys --

          "XF86AudioRaiseVolume" =
            "exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+";
          "XF86AudioLowerVolume" =
            "exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-";
          "XF86AudioMute" =
            "exec --no-startup-id wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };
        defaultWorkspace = "workspace ${workspaces.ws1}";
        workspaceOutputAssign = [
          { workspace = workspaces.ws1; output = outputs.mon1; }
          { workspace = workspaces.ws2; output = outputs.mon1; }
          { workspace = workspaces.ws3; output = outputs.mon2; }
          { workspace = workspaces.ws4; output = outputs.mon2; }
          { workspace = workspaces.ws5; output = outputs.mon2; }
          { workspace = workspaces.ws6; output = outputs.mon2; }
          { workspace = workspaces.ws7; output = outputs.mon3; }
          { workspace = workspaces.ws8; output = outputs.mon3; }
          { workspace = workspaces.ws9; output = outputs.mon3; }
          { workspace = workspaces.ws10; output = outputs.mon3; }
        ];
        window = {
          titlebar = false;
          border = 2;
          hideEdgeBorders = "none";
        };
        floating = {
          border = 2;
        };
        gaps = {
          inner = 8;
          outer = 1;
          smartBorders = "no_gaps";
        };
        # These are the catppuccin mocha colors (applying them manually here
        # instead of using built-in method).
        colors =
          let
            background = "#1e1e2e"; # base
            background2 = "#313244"; # surface0
            foreground = "#cdd6f4"; # text
            comments = "#585b70"; # surface2
            highlight = "#b4befe"; # lavender
            red = "#f38ba8";
          in
          {
            focused = {
              border = highlight;
              background = background2;
              text = foreground;
              indicator = highlight;
              childBorder = highlight;
            };
            focusedInactive = {
              border = background2;
              background = background;
              text = comments;
              indicator = background;
              childBorder = background2;
            };
            unfocused = {
              border = background2;
              background = background;
              text = comments;
              indicator = background;
              childBorder = background2;
            };
            urgent = {
              border = foreground;
              background = red;
              text = foreground;
              indicator = red;
              childBorder = red;
            };
            background = background;
          };
      };
  };

  home.packages = [
    pkgs.wl-clipboard
  ];
}
