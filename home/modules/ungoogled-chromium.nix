{
  options,
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
    extensions =
      let
        createChromiumExtensionFor =
          browserVersion:
          {
            id,
            sha256,
            version,
          }:
          {
            inherit id;
            crxPath = builtins.fetchurl {
              url = "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${browserVersion}&x=id%3D${id}%26installsource%3Dondemand%26uc";
              name = "${id}.crx";
              inherit sha256;
            };
            inherit version;
          };
        createChromiumExtension = createChromiumExtensionFor (
          lib.versions.major pkgs.ungoogled-chromium.version
        );
      in
      [
        # 1Password
        (createChromiumExtension {
          id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa";
          sha256 = "sha256:1ry8h3as008b9d9jr3q9jaqxxfnvylalp3jcsyd21ap8khzs1p2p";
          version = "8.12.2.37";
        })
        # uBlock Origin Lite
        (createChromiumExtension {
          id = "ddkjiahejlhfcafbddmgiahcphecmpfh";
          sha256 = "sha256:0phxxm2scxn7nhxf51ygs3hbkq5hvf5rahhz0nhwi6arsb4vc2lv";
          version = "2026.215.1801";
        })
        # Vimium
        (createChromiumExtension {
          id = "dbepggeogbaibhgnhhndojpepiihcmeb";
          sha256 = "sha256:0f0gm9p88y8d26lv0cy3i2idl8whn7bphwm2p3cvrl5i5nh6waq1";
          version = "2.4.0";
        })
        # Catppuccin Theme
        (createChromiumExtension {
          id = "bkkmolkhemgaeaeggcmfbghljjjoofoh";
          sha256 = "sha256:01bzcbpxgrzmwp514q7fgp8g144bs7rzfmp0r07g6ysq0ykbhz3v";
          version = "5.0.0";
        })

      ];
    commandLineArgs = [
      "--force-dark-mode"
    ];
  };
}
