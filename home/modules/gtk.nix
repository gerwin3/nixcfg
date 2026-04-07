{ pkgs, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.adwaita-icon-theme;
    };
    iconTheme = {
      name = "Adwaita-dark";
      package = pkgs.adwaita-icon-theme;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
    # Adopt the new default for `gtk.gtk4.theme`. Original evaluation warning
    # that triggered this change:
    #   The default value of `gtk.gtk4.theme` has changed from `config.gtk.theme`
    #   to `null`.
    #   You are currently using the legacy default (`config.gtk.theme`) because
    #   `home.stateVersion` is less than "26.05"
    gtk4.theme = null;
    # This is deprecated. No alternative so now, so we use adwaita-dark instead.
    # catppuccin.enable = true;
  };

  home.sessionVariables.GTK_THEME = "Adwaita:dark";
}
