{ pkgs, ... }:

{
  boot = {
    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "systemd.show_status=auto"
    ];

    consoleLogLevel = 3;

    initrd.systemd.enable = true;
    initrd.verbose = false;

    plymouth = {
      enable = true;
      theme = "cross_hud";
      themePackages = [
        (pkgs.adi1090x-plymouth-themes.override {
          selected_themes = [ "cross_hud" ];
        })
      ];
    };
  };
}
