{ ... }:

{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    # PipeWire 1.6.x on unstable currently advertises LDAC, but on this setup
    # LDAC negotiation fails at runtime. Restrict Bluetooth audio to codecs that
    # work reliably so headsets reconnect without manual intervention.
    wireplumber.extraConfig."10-bluetooth-codecs" = {
      "monitor.bluez.properties" = {
        "override.bluez5.codecs" = [
          "sbc"
          "sbc_xq"
          "aac"
        ];
      };
    };
  };
}
