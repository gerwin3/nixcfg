{ ... }:

{
  programs.gh.enable = true;
  # Note: There is no need for persistance paths for `gh` since it stores
  # tokens in the GNOME keyring.

  programs.gh-dash = {
    enable = true;
    catppuccin.enable = true;
  };
}
