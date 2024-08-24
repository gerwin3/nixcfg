{ ... }:

{
  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      position = "top";
      modules-left = [ "sway/workspaces" ];
      modules-center = [ ];
      modules-right = [ "cpu" "memory" "pulseaudio" "clock" ];
      margin-top = 2;
      margin-bottom = -6;
      margin-left = 5;
      margin-right = 5;
      clock = {
        format = "  {:%Y-%m-%d %H:%M:%S}";
        interval = 1;
        tooltip-format = "{:%A, %B %d, %Y (%R)}";
      };
      cpu = {
        format = "  {usage}%";
      };
      memory = {
        format = "  {percentage}%";
      };
      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = " {volume}%";
        format-icons = {
          headphone = " ";
          handsfree = " ";
          headset = " ";
          default = [ "" "" "" ];
        };
      };
      # Always show workspaces on designated monitors, even when there are no
      # windows.
      "sway/workspaces" = {
        persistent-workspaces = {
          "1" = [ "DP-1" ];
          "2" = [ "DP-1" ];
          "3" = [ "DP-2" ];
          "4" = [ "DP-2" ];
          "5" = [ "DP-2" ];
          "6" = [ "DP-2" ];
          "7" = [ "HDMI-A-1" ];
          "8" = [ "HDMI-A-1" ];
          "9" = [ "HDMI-A-1" ];
          "10" = [ "HDMI-A-1" ];
        };
      };
    }];
    style = ''
      * {
        border-radius: 0px;
        color: @text;
        font-family: "Iosevka Nerd Font";
        margin: 0px;
        padding: 0px;
        transition-duration: 0s;
        transition-property: none;
      }
      #waybar {
        background: transparent;
        border-bottom: none;
      }
      #workspaces button {
        border-width: 0px;
        border-color: transparent;
        background: transparent;
        color: @text;
        margin-left: 4px;
        margin-top: 3px;
        margin-right: 4px;
        margin-bottom: 3px;
        min-width: 0px;
        opacity: 0.75;
        padding-left: 3px;
        padding-bottom: 0px;
        padding-right: 3px;
        padding-top: 1px;
        text-shadow: none;
      }
      #workspaces button:hover {
        border-color: transparent;
        border-top: none;
        border-width: 0px;
        box-shadow: none;
        font-weight: normal;
        opacity: 1.0;
        text-shadow: none;
      }
      #workspaces button.focused {
        border-width: 0px;
        border-color: transparent;
        background: transparent;
        color: @text;
        font-weight: bold;
        text-shadow: none;
        opacity: 1.0;
      }
      #window {
        background: transparent;
        opacity: 0.65;
      }
      #clock,
      #cpu,
      #memory,
      #pulseaudio,
      #tray {
      	border-radius: 2px;
        background: transparent;
        color: @text;
        margin-left: 4px;
        margin-top: 3px;
        margin-right: 4px;
        margin-bottom: 3px;
        padding-left: 5px;
        padding-top: 1px;
        padding-right: 5px;
        padding-bottom: 0px;
      }
      #tray       { color: @rosewater; }
      #cpu        { color: @pink; }
      #memory     { color: @pink; }
      #pulseaudio { color: @pink; }
      #clock      { color: @lavender; }

      #pulseaudio.muted {
        opacity: 0.5;
      }
    '';
    catppuccin.enable = true;
  };
}

# Sources:
# * https://github.com/hfytr/dotfiles/blob/main/system/home-manager/waybar/config.json
