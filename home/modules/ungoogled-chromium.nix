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
        # uBlock Origin
        (createChromiumExtension {
          id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
          sha256 = "sha256:0ksbby7sim15b6ym8m3yjw3zz0942r9sg43grqpv1cckb55c4ha8";
          version = "2026.215.1801";
        })
        # I Still Don't Care About Cookies
        (createChromiumExtension {
          id = "edibdbjcniadpccecjdfdjjppcpchdlm";
          sha256 = "sha256:0zf320qf2n7ivrab2qwf9i0fxh8wbsf1gn9ldmy2kpa30g1wvdj6";
          version = "1.1.9";
        })
        # Vimium
        (createChromiumExtension {
          id = "dbepggeogbaibhgnhhndojpepiihcmeb";
          sha256 = "sha256:0f0gm9p88y8d26lv0cy3i2idl8whn7bphwm2p3cvrl5i5nh6waq1";
          version = "2.4.0";
        })
      ];
    commandLineArgs = [
      "--force-dark-mode"
    ];
  };
}
