{ ... }:

{
  services.timesyncd.enable = true;

  # Ensure time sync works even if DNS/TLS is broken at boot by connecting to
  # the NTP servers directly over IP.
  networking.timeServers = [
    "162.159.200.1"
    "162.159.200.123"
    "2606:4700:f1::1"
    "2606:4700:f1::123"
  ];
}
