#!/usr/bin/env bash

# Starts mattermost and ncspot, nicely tiled on workspace 10.

swaymsg 'workspace 10; split h; exec --no-startup-id foot matterhorn'
sleep 0.5
swaymsg 'exec --no-startup-id foot ncspot'
sleep 0.5
swaymsg 'resize shrink width 20 px or 20 ppt'
sleep 0.1
swaymsg 'split v; exec --no-startup-id foot nix run nixpkgs#pipes'
sleep 0.5
swaymsg 'resize shrink height 10 px or 10 ppt'
