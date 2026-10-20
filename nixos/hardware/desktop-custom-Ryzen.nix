{
  config,
  lib,
  pkgs,
  ...
}:

{
  boot = {
    # This machine already had Windows installed. Windows creates just a tiny
    # /boot partition of 100MB. That is not enough for NixOS, since it wants to
    # store kernels, generations, etc. on there. To work around this, I added an
    # XBOOTLDR partition of 4GB mounted at /boot which will store kernels etc.
    # and then use the Windows boot partition for EFI.
    # See: https://wiki.nixos.org/wiki/Dual_Booting_NixOS_and_Windows
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.xbootldrMountPoint = "/boot";
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/efi";

    extraModulePackages = [ ];
    kernelModules = [ "kvm-amd" ];
    kernelPackages = pkgs.linuxPackages_latest;

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
      luks.devices."root".device = "/dev/disk/by-uuid/90455870-a43b-4505-86cb-542e59235813";
    };
  };

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [
      "defaults"
      "size=64G"
      "mode=755"
    ];
    neededForBoot = true;
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/78176526-7172-4199-a08c-13066a10c05d";
    fsType = "btrfs";
    options = [ "subvol=nix" ];
    neededForBoot = true;
  };

  fileSystems."/persist" = {
    device = "/dev/disk/by-uuid/78176526-7172-4199-a08c-13066a10c05d";
    fsType = "btrfs";
    options = [ "subvol=persist" ];
    neededForBoot = true;
  };

  fileSystems."/efi" = {
    device = "/dev/disk/by-uuid/8CBE-F1FB";
    fsType = "vfat";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/6341-B56A";
    fsType = "vfat";
  };

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  swapDevices = [ ];
}
