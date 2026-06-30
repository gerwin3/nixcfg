{ pkgs, ... }:

{
  programs.neovim = {
    defaultEditor = true;
    enable = true;
    extraPackages = with pkgs; [ ];
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withPython3 = false;
    withRuby = false;
  };
}
