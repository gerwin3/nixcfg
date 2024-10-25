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
        "thunderbolt"
        "usb_storage"
        "sd_mod"
      ];
      kernelModules = [ ];
      luks.devices."root".device = "/dev/disk/by-uuid/96edbc57-4610-49f7-a86b-35858431bc0b";
    };
  };

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [
      "defaults"
      "size=15G"
      "mode=755"
    ];
    neededForBoot = true;
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/fdf62c87-45d0-4807-a43d-1967ca29a30b";
    fsType = "btrfs";
    options = [ "subvol=nix" ];
    neededForBoot = true;
  };

  fileSystems."/persist" = {
    device = "/dev/disk/by-uuid/fdf62c87-45d0-4807-a43d-1967ca29a30b";
    fsType = "btrfs";
    options = [ "subvol=persist" ];
    neededForBoot = true;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D8DC-96BE";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # Took these battery settings from here:
  # > https://kirarin.hootr.club/git/steinuil/flakes/src/branch/master/hosts/starry/hardware.nix
  # Note that the source also contained configuration for something called
  # "tlp" but it conflicted with power-profiles-daemon which is somehow enabled
  # (probably from nixos-hardware). So I only kept the powerManagement section.
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
    powertop.enable = true;
  };

  services.logind.lidSwitch = "suspend";

  swapDevices = [ ];
}
