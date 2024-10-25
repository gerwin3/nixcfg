{
  config,
  lib,
  pkgs,
  ...
}:

{
  boot = {
    extraModulePackages = [ ];
    kernelModules = [ "kvm-amd" ];
    kernelPackages = pkgs.linuxPackages_latest;
    loader.efi.canTouchEfiVariables = true;
    initrd = {
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
      kernelModules = [ ];
      luks.devices."root".device = "/dev/disk/by-uuid/f6567372-7007-4bed-9961-d6ddae3738c1";
    };
  };

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

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
    device = "/dev/disk/by-uuid/049e8a7b-0508-42f6-9efa-8ed2e935b7cc";
    fsType = "btrfs";
    options = [ "subvol=nix" ];
    neededForBoot = true;
  };

  fileSystems."/persist" = {
    device = "/dev/disk/by-uuid/049e8a7b-0508-42f6-9efa-8ed2e935b7cc";
    fsType = "btrfs";
    options = [ "subvol=persist" ];
    neededForBoot = true;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/2C9D-AE2E";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  swapDevices = [ ];
}
