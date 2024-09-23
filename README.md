# `nixcfg`

## Usage

I keep my nixcfg repository separate from `/etc/nixos`. After making changes, the `apply.sh` script copies the config into `/etc/nixos` and rebuilds the system.

```sh
./apply
```

To update the system, use:

```sh
./apply --update
```

This will apply the configuration, as well as updating the lock file.

## Known Issues

* Flickering on Sway with NVIDIA: Sway's latest release is based on wlroots 0.17 which does not have explicit sync support. This will be fixed in the next Sway release which will be based on wlroots 0.19 (0.18 and above have explicit sync).

## Installation

First, create a bootable medium from the [minimal NixOS installation image](https://nixos.org/download/), and boot from it on the target machine. Then follow the installation steps:

1. Clone this repository:

    ```bash
    git clone https://github.com/gerwin3/nixcfg.git
    ```

2. Partition the disks as needed. This configuration expects the following
   partitions to exist:

   * A `nix` partition mounted on `/nix`.
   * A `persist` partition mounted on `/persist`.
   * A transient partition (like `tmpfs`) on `/`.

   The recommended setup is to create a LUKS disk, then create a btrfs
   filesystem on it and configure the `nix` and `persist` partitions as btrfs
   subvolumes.

   These are (roughly) the steps needed to partition the disk and create the
   necessary file systems:
   
    ```bash
    # Partition a primary disk and a 2GB boot partition.
    parted /dev/nvme0n1 -- mklabel gpt
    parted /dev/nvme0n1 -- mkpart root 2048MB 100%
    parted /dev/nvme0n1 -- mkpart ESP fat32 1MB 2048MB
    parted /dev/nvme0n1 -- set 2 esp on

    # Format and the boot partition (from NixOS installation guide).
    mkfs.fat -F 32 -n boot /dev/nvme0n1p2
    mkdir -p /mnt/boot

    # Format LUKS encrypted partition, and create btrfs filesystem inside it.
    cryptsetup luksFormat /dev/nvme0n1p1
    cryptsetup open /dev/nvme0n1p1 root
    mkfs.btrfs /dev/mapper/root
    mount /dev/mapper/root /mnt
    # Create subvolumes for nix and persistence, then mount them.
    btrfs subvolume create /mnt/nix
    btrfs subvolume create /mnt/persist
    # Unmount /mnt here since we only need /mnt/boot, /mnt/nix and /mnt/persist
    umount /mnt

    # Mount all disks
    mount -o umask=077 /dev/disk/by-label/boot /mnt/boot
    mount -o subvol=nix /dev/mapper/root /mnt/nix
    mount -o subvol=persist /dev/mapper/root /mnt/persist
    ```

> [!NOTE]
> Refer to the [NixOS installation guide UEFI section](https://nixos.org/manual/nixos/stable/#sec-installation-manual-partitioning-UEFI)
> for more information.

3. Generate the hardware configuration with `nixos-generate-config` or use one
   of the pre-defined ones. Either way, make sure to modify the configuration
   to suit your needs.

   Edit `flake.nix` under `nixConfigurations` and add a new configuration.
   Import the preffered hardware configuration there.

   The `tmpfs` file system entry needs to be added manually, for example:

    ```nix
    fileSystems."/" = {
      device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=25G" "mode=755" ];
      neededForBoot = true;
    };
    ```

   In the example above, the `tmpfs` file system is 25GB in size. Make sure
   this number is lower than the available RAM in the system.

   This is also the time to add other useful stuff:

    ```nix
    kernelPackages = pkgs.linuxPackages_latest;
    loader.efi.canTouchEfiVariables = true;
    ```

   Also for persistence it is necessary to add `neededForBoot` attributes to
   each of the three volumes: `nix`, `persistence` and `tmpfs`:

    ```nix
    fileSystems."/".neededForBoot = true;
    fileSystems."/nix".neededForBoot = true;
    fileSystems."/persist".neededForBoot = true;
    ```

   Refer to [framework-13-Ryzen.nix](./nixos/hardware/framework-13-Ryzen.nix) for
   a good starting point.

> [!NOTE]
> It is advisable to temporarily comment out the private modules such
> as `wireguard.nix` and re-add them after installation when git credentials
> have been set up.

4. Generate your user password:

    ```bash
    echo "Enter password for main user:" && \
        mkdir secrets && \
        mkpasswd -m yescrypt | tr -d '\n' > secrets/password
    ```

5. Create configuration directories:

    ```bash
    sudo mkdir -p /mnt/persist/etc/nixos && \
        sudo cp -r * /mnt/persist/etc/nixos
    ```

6. Perform installation:

    Put the name of the configuration (chosen in step 3) after the hash.

    ```bash
    sudo nixos-install --no-root-passwd --flake /mnt/persist/etc/nixos#system && \
        sudo reboot now
    ```
