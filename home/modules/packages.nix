{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # ricing
    neofetch

    # search
    ripgrep
    fzf

    # compression tools
    zip
    unzip
    zstd
    gnutar

    # encryption
    gnupg

    # formats
    jq

    # system usage monitoring
    btop
    iotop
    iftop

    # system call monitoring
    strace
    ltrace
    lsof

    # system tools
    sysstat
    lm_sensors
    ethtool
    pciutils
    usbutils

    # secret management
    # Note: Required for `secret-tool` (used by some applications for getting
    # tokens).
    libsecret

    # file management
    file
    which
    tree

    # file manipulation
    gnused

    # images
    swayimg

    # screenshot tools
    grim
    slurp

    # lol
    cowsay
  ];
}
