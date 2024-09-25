{ config, ... }:

{
  hardware = {
    graphics.enable = true;

    nvidia = {
      # NOTE: Tried forceFullCompositionPipeline and it does not have effect.
      # Probably the real fix is downstream wl-roots in master Sway.
      # forceFullCompositionPipeline = true;

      # TODO: Modesetting has stopped working and I think it is causing Sway to
      # miss workspace 2 for some reason. A possible fix would be reverting to
      # the stable version of NVIDIA most likely but I'm not feeling like it
      # right now so we'll see.
      modesetting.enable = true;

      nvidiaSettings = true;

      # NOTE: Disabled for now since I am having issues.
      # open = true;

      package = config.boot.kernelPackages.nvidiaPackages.latest;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}
