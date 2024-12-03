{ lib, variant, ... }:

{
  imports =
    [
      modules/bash.nix
      modules/btop.nix
      modules/catppuccin.nix
      modules/direnv.nix
      modules/firefox.nix
      modules/fonts.nix
      modules/foot.nix
      modules/fzf.nix
      modules/gh-dash.nix
      modules/git.nix
      modules/gtk.nix
      modules/matterhorn.nix
      modules/ncspot.nix
      modules/neovim.nix
      modules/nix.nix
      modules/packages.nix
      modules/scripts.nix
      modules/sway.nix
      modules/swaylock.nix
      modules/waybar.nix
      modules/zed.nix
    ]
    ++ (lib.optional (variant == "desktop") modules/sway.desktop.nix)
    ++ (lib.optional (variant == "laptop") modules/sway.laptop.nix);

  home = {
    username = "gerwin";
    homeDirectory = "/home/gerwin";
    stateVersion = "23.11"; # Never change this.
  };

  programs.home-manager.enable = true;

  services.gnome-keyring.enable = true;

  systemd.user.startServices = "sd-switch";
}
