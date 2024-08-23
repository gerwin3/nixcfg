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

This will do all of the above, as well as updating the lock file.

## Installation

First, create a bootable medium from the [minimal NixOS installation image](https://nixos.org/download/), and boot from it on the target machine.

> [!NOTE]
> It is easier to connect to the target machine over SSH and run installation
> from there. An SSH server is already configured, you just need to set a
> password for the `nixos` user:
>
> ```bash
> passwd
> ```
> 
> Then find the target host IP address:
>
> ```bash
> ip address
> ```

Then perform the installation on the target machine:

1. Copy over the nix configuration to the target host:

    ```bash
    scp -r * nixos@$10.0.0.1:~
    ```

2. Partition the disks as needed. This configuration expects the following
   partitions to exist:

   * A `nix` partition mounted on `/nix`.
   * A `persist` partition mounted on `/persist`.
   * A transient partition (like `tmpfs`) on `/`.

   The recommended setup is to create a LUKS disk, then create a btrfs
   filesystem on it and configure the `nix` and `persist` partitions as btrfs
   subvolumes.

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

## Installation on Mac with Asahi

1. Download a modified NixOS bootable ISO with Asahi support [from nixos-apple-silicon releases](https://github.com/tpwrules/nixos-apple-silicon/releases) and create a bootable USB using `dd` (from Linux or macOS).

2. Install Asahi UEFI by following the [NixOS Apple Silicon Guide](https://github.com/tpwrules/nixos-apple-silicon/blob/main/docs/uefi-standalone.md#uefi-preparation) from "UEFI Preparation" onwards.

> [!WARNING]  
> Make sure to select the correct partition. It will usually be
> `/dev/nvme0n1p5` but use the steps from the NixOS Apple Silicon Guide to
> check.

3. When you get to partitioning and formatting, instead of setting up `ext4`, use the following steps to set up an encrypted `btrfs` partition:

    First, switch to the root user:

    ```bash
    sudo su
    ```

    Second, use `nix-shell` to get the `btrfs` tools. (They are not part of the installation ISO by default.)

    ```bash
    nix-shell -p btrfs-progs
    ```

    Then continue with creating the LUKS encrypted partition with `btrfs`:
    
    ```bash
    # Create a new partition in the empty space created by the Asahi installer.
    sgdisk /dev/nvme0n1 -n 0:0 -s
    # Create a LUKS partition and open it.
    cryptsetup luksFormat /dev/nvme0n1p5
    cryptsetup open /dev/nvme0n1p5 crypted
    # Create a BTRFS filesystem on the encrypted partition.
    mkfs.btrfs /dev/mapper/crypted
    mount /dev/mapper/crypted /mnt
    # Create and mount the `nix` and `persist` subvolumes.
    btrfs subvolume create /mnt/nix
    btrfs subvolume create /mnt/persist
    mount -o subvol=nix /dev/mapper/crypted /mnt/nix
    mount -o subvol=persist /dev/mapper/crypted /mnt/persist
    ```

    Finally, mount the boot partition:

    ```bash
    mkdir -p /mnt/boot
    mount /dev/disk/by-partuuid/`cat /proc/device-tree/chosen/asahi,efi-system-partition` /mnt/boot
    ```

4. Follow step 3 through 5 from the general installation guide above. There's already a hardware configuration file for a MacBook M2 Air (in the `laptop` system configuration) that works.

> [!WARNING]  
> If you reuse it (instead of creating your own), make sure to update the
> disks, since the UUID's will change after recreating the disks.

5. Make sure to make the following changes to the hardware configuration:

    * Set `boot.loader.efi.canTouchEfiVariables = false`.
    * Set `hardware.asahi.extractPeripheralFirmware = false`. This can be changed later but it must be set to `false` during installation.

    * Override the default root filesystem entry:

        ```nix
        fileSystems."/" = {
          device = "none";
          fsType = "tmpfs";
          options = [ "defaults" "size=25G" "mode=755" ];
        };
        ```

    * And set the `neededForBoot` flags:

        ```nix
        fileSystems."/".neededForBoot = true;
        fileSystems."/nix".neededForBoot = true;
        fileSystems."/persist".neededForBoot = true;
        ```

    If you use the hardware configuration that is included in this repository, most settings will be correct, except for `extractPeripheralFirmware`. It needs to be disabled manually before installing (and can be changed later).

6. Copy over the `apple-silicon-support` module from the installation medium:

    ```bash
    sudo cp -r /etc/nixos/apple-silicon-support /mnt/persist/etc/nixos/
    ```

> [!NOTE]
> The command below assumes the default `laptop` configuration.

> [!NOTE]
> If the USB stick does not have enough storage space to build NixOS, the
> installer might fail. To get around it, symlink `/tmp` to the host disk:
>
> ```bash
> rm -r /tmp
> mkdir /mnt/tmp
> chmod 1777 /mnt/tmp
> ln -s /mnt/tmp /tmp
> ```

7. Perform installation:

    ```bash
    sudo nixos-install --no-root-passwd --flake /mnt/persist/etc/nixos#laptop && \
        sudo reboot now
    ```

8. After installation, copy over the firmware (which is now present on `/boot`):

    ```bash
    sudo mkdir -p /etc/nixos/nixos/hardware/firmware
    sudo cp /boot/asahi/{all_firmware.tar.gz,kernelcache*} /etc/nixos/nixos/hardware/firmware
    ```

    Then, comment `hardware.asahi.extractPeripheralFirmware = false` back out
    and revert to the original settings, and rebuild. Make sure to use the
    `--impure` flag when rebuilding.

## Resources

* [NixOS Apple Silicon Guide](https://github.com/tpwrules/nixos-apple-silicon/blob/main/docs/uefi-standalone.md)
