{ ... }:

{
  imports = [
    modules/1password.nix
    modules/bluetooth.nix
    modules/boot.nix
    modules/firmware.nix
    modules/fonts.nix
    modules/gnome.nix
    modules/greetd.nix
    modules/locale.nix
    modules/networking.nix
    modules/nix.nix
    modules/nvidia.nix
    modules/persistence.nix
    modules/pipewire.nix
    modules/security.nix
    modules/swaylock.nix
    modules/users.nix
    modules/wireguard.nix
  ];

  system.stateVersion = "23.11"; # Never change this.
}
