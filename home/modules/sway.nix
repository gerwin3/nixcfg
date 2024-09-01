{ pkgs, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    config =
      let
        mod = "Mod4";
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
          "${mod}+m" = "mode move";
          "${mod}+n" = "workspace next_on_output";
          "${mod}+p" = "workspace prev_on_output";
          "${mod}+t" = "mode take";
          "${mod}+u" = "split h";
          "${mod}+v" = "split v";
          "${mod}+w" = "layout tabbed";

          "${mod}+1" = "workspace 1";
          "${mod}+2" = "workspace 2";
          "${mod}+3" = "workspace 3";
          "${mod}+4" = "workspace 4";
          "${mod}+5" = "workspace 5";
          "${mod}+6" = "workspace 6";
          "${mod}+7" = "workspace 7";
          "${mod}+8" = "workspace 8";
          "${mod}+9" = "workspace 9";
          "${mod}+0" = "workspace 10";

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

          "${mod}+Shift+1" = "move container to workspace 1; workspace 1";
          "${mod}+Shift+2" = "move container to workspace 2; workspace 2";
          "${mod}+Shift+3" = "move container to workspace 3; workspace 3";
          "${mod}+Shift+4" = "move container to workspace 4; workspace 4";
          "${mod}+Shift+5" = "move container to workspace 5; workspace 5";
          "${mod}+Shift+6" = "move container to workspace 6; workspace 6";
          "${mod}+Shift+7" = "move container to workspace 7; workspace 7";
          "${mod}+Shift+8" = "move container to workspace 8; workspace 8";
          "${mod}+Shift+9" = "move container to workspace 9; workspace 9";
          "${mod}+Shift+0" = "move container to workspace 10; workspace 10";

          # -- Hardware keys --

          "XF86AudioRaiseVolume" =
            "exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+";
          "XF86AudioLowerVolume" =
            "exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-";
          "XF86AudioMute" =
            "exec --no-startup-id wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };
        defaultWorkspace = "workspace 1";
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

    extraConfig = ''
      focus_follows_mouse no
    '';

    wrapperFeatures.gtk = true;
  };

  home.packages = [
    pkgs.wl-clipboard
  ];
}
