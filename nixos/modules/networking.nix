{ ... }:

{
  networking.nameservers = [
    "1.1.1.1#one.one.one.one"
    "1.0.0.1#one.one.one.one"
  ];
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  services.resolved = {
    enable = true;
    settings = {
      Resolve = {
        DNSSEC = "true";
        DNSOverTLS = "true";
        Domains = [ "~." ];
        FallbackDNS = [
          "1.1.1.1#one.one.one.one"
          "1.0.0.1#one.one.one.one"
        ];
      };
    };
  };
}
