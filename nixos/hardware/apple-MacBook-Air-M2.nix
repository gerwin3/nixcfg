{ lib, ... }:

{
  boot = {
    consoleLogLevel = 0;
    extraModulePackages = [ ];
    kernelModules = [ ];
    kernelParams = [ "apple_dcp.show_notch=1" ];
    loader.efi.canTouchEfiVariables = false;
    initrd = {
      availableKernelModules = [ "usb_storage" ];
      kernelModules = [ ];
      luks.devices."crypted".device = "/dev/disk/by-uuid/900ad806-082b-42f1-a1c5-a9259563a7b8";
    };
  };

  # This section configures Asahi and needs some special attention, since most
  # of it requires the firmware to be present. Since the firmware is not yet
  # there during installation, the "hardware" section should be entirely
  # commented out during installation, and then reverted later.
  #
  # ALso, the `extractPeripheralFirmware` must be set to false during
  # installation, uncomment this line:
  # hardware.asahi.extractPeripheralFirmware = false;
  #
  # Then re-enable this section after installation completes, and rebuild:
  hardware = {
    asahi = {
      extractPeripheralFirmware = true;
      peripheralFirmwareDirectory = ./firmware;
      useExperimentalGPUDriver = true;
    };
    opengl.enable = true;
  };

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [
      "defaults"
      "size=25G"
      "mode=755"
    ];
    neededForBoot = true;
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/37e28276-f4c4-4f48-9d3d-57feff79f074";
    fsType = "btrfs";
    options = [ "subvol=nix" ];
    neededForBoot = true;
  };

  fileSystems."/persist" = {
    device = "/dev/disk/by-uuid/37e28276-f4c4-4f48-9d3d-57feff79f074";
    fsType = "btrfs";
    options = [ "subvol=persist" ];
    neededForBoot = true;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/41F1-1713";
    fsType = "vfat";
  };

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
  swapDevices = [ ];
}
