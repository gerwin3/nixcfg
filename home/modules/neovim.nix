{ pkgs, ... }:

{
  home.file.".config/nvim/" = {
    source = ../extra/neovim;
    recursive = true;
  };

  programs.neovim = {
    defaultEditor = true;
    enable = true;
    # For most projects it is recommended to have the development dependencies be
    # part of the devshell. Configuration file formats are an exception to this
    # since they can appear anywhere. So we load LSP support for them here:
    extraPackages = with pkgs; [
      # Language servers and formatters
      ## Nix
      nil
      nixfmt
      ## TOML
      taplo
      # Compiler to satisfy treesitter.
      gcc
    ];
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
