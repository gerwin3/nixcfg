{ config, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    graphics.enable = true;

    nvidia = {
      # NOTE: Tried forceFullCompositionPipeline and it does not have effect.
      # Probably the real fix is downstream wl-roots in master Sway.
      # forceFullCompositionPipeline = true;

      modesetting.enable = true;
      nvidiaSettings = true;
      open = true;

      # TODO: Now on stable because on latest KMS does not work which causes
      # other issues in Sway etc.
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      # package = config.boot.kernelPackages.nvidiaPackages.latest;

      powerManagement = {
        enable = false;
        finegrained = false;
      };
    };
  };
}
