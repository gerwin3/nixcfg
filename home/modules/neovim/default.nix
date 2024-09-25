{ lib, ... }:

{
  imports = [
    ./copilot.nix
    ./nix.nix
  ];

  programs.neovim = {
    defaultEditor = true;
    enable = true;
    extraLuaConfig = lib.fileContents ./init.lua;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
