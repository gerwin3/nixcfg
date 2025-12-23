{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # ricing
    neofetch

    # calculator
    calc
    fend

    # search
    ripgrep

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
    yazi
    file
    which
    tree

    # file manipulation
    gnused
    hexyl

    # images
    swayimg

    # screenshot tools
    grim
    slurp

    # video
    ffmpeg

    # desktop environment
    sway-launcher-desktop

    # assistants
    codex

    # lol
    cowsay
  ];
}
