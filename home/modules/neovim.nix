{ pkgs, lib, ... }:

{
  programs.neovim = {
    defaultEditor = true;
    enable = true;
    extraLuaConfig = lib.fileContents ../../extra/neovim/init.lua;
    # For most projects it is recommended to have the development dependencies be
    # part of the devshell. Configuration file formats are an exception to this
    # since they can appear anywhere. So we load LSP support for them here:
    extraPackages = with pkgs; [
      # Language servers and formatters
      ## Nix
      nil
      nixpkgs-fmt
      ## TOML
      taplo
    ];
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    # Required for the Copilot plugin.
    withNodeJs = true;
  };
}
