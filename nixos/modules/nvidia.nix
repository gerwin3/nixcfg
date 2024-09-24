{ config, ... }:

{
  hardware = {
    graphics.enable = true;

    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
    };
  };

  # FIXME: This part is taken from the NixOS wiki recommendations. Specifically
  # the section on "Booting to Text Mode". Hopefully this will fix modesetting.
  boot = {
    extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
    initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}
