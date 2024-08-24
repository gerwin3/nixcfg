{ pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd 'sway --unsupported-gpu'";
        user = "gerwin";
      };
    };

    # Use tty2 since tty1 is used by systemd boot logging.
    vt = 2;
  };
}
