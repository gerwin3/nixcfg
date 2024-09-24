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

  boot = {
    initrd.kernelModules = [ "nvidia" "nvidia_modeset" ];
    kernelParams = [ "nvidia-drm.fbdev=1" ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}
