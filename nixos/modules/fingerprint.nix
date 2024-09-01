{ ... }:

{
  # You must manually enroll the fingerpints before using this;
  # $ sudo fprintd-enroll -f right-index-finger gerwin

  # To test it:
  # $ fprintd-verify

  services.fprintd.enable = true;

  security.pam.services.swaylock = {
    text = ''
      auth sufficient pam_unix.so try_first_pass likeauth nullok
      auth sufficient pam_fprintd.so
      auth include login
    '';
    fprintAuth = true;
  };
}
