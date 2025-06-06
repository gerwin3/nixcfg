{ lib, variant, ... }:

{
  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        modules-left = [ "sway/workspaces" ];
        modules-center = [ ];
        modules-right =
          [
            "cpu"
            "memory"
            "pulseaudio"
          ]
          ++ lib.optional (variant == "laptop") "battery"
          ++ [ "clock" ];
        margin-top = 2;
        margin-bottom = -6;
        margin-left = 5;
        margin-right = 5;
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-alt = "{time} {icon}";
          format-full = "󰁹 {capacity}%";
          format-icons = [
            "󰁺"
            "󰁾"
            "󰂁"
          ];
        };
        clock = {
          format = " {:%Y-%m-%d %H:%M:%S}";
          interval = 1;
          tooltip-format = "{:%A, %B %d, %Y (%R)}";
        };
        cpu = {
          format = " {usage}%";
        };
        memory = {
          format = " {percentage}%";
        };
        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = " {volume}%";
          format-icons = {
            headphone = " ";
            handsfree = " ";
            headset = " ";
            default = [
              ""
              ""
              ""
            ];
          };
        };
      }
    ];
    style = ''
      * {
        border-radius: 0px;
        color: @text;
        font-family: "BerkeleyMono Nerd Font";
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
      #battery,
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
      #battery    { color: @mauve; }
      #clock      { color: @lavender; }

      #pulseaudio.muted {
        opacity: 0.5;
      }
    '';
  };
}

# Sources:
# * https://github.com/hfytr/dotfiles/blob/main/system/home-manager/waybar/config.json
