{ ... }:

{
  services.fprintd.enable = true;
  security.pam.services.swaylock = { };
  security.pam.services.swaylock.fprintAuth = true;
}
