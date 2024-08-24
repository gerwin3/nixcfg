{ ... }:

{
  boot = {
    loader.systemd-boot.enable = true;

    # Force boot systemd output on tty1 so we free up tty2 for greetd.
    kernelParams = [ "console=tty1" ];
  };
}
