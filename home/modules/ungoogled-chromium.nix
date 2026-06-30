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
        createChromiumExtension =
          {
            id,
            version,
            crxFile,
          }:
          {
            inherit id;
            crxPath = ../extra/ungoogled-chromium/plugins + "/${crxFile}";
            inherit version;
          };
      in
      [
        # 1Password
        (createChromiumExtension {
          id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa";
          version = "8.12.2.37";
          crxFile = "1password.crx";
        })
        # uBlock Origin Lite
        (createChromiumExtension {
          id = "ddkjiahejlhfcafbddmgiahcphecmpfh";
          version = "2026.215.1801";
          crxFile = "ublock-origin-lite.crx";
        })
        # Vimium
        (createChromiumExtension {
          id = "dbepggeogbaibhgnhhndojpepiihcmeb";
          version = "2.4.0";
          crxFile = "vimium.crx";
        })
        # Catppuccin Theme
        (createChromiumExtension {
          id = "bkkmolkhemgaeaeggcmfbghljjjoofoh";
          version = "5.0.0";
          crxFile = "catppuccin-theme.crx";
        })

      ];
    commandLineArgs = [
      "--force-dark-mode"
    ];
  };
}
