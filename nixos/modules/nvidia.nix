{ config, ... }:

{
  hardware = {
    graphics.enable = true;

    nvidia = {
      forceFullCompositionPipeline = true;
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
    extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}
