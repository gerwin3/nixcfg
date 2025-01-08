{ pkgs, lib, ... }:

{
  home.file.".config/nvim/" = { source = ../extra/neovim; recursive = true; };

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
      nixfmt-rfc-style
      ## TOML
      taplo
      # Compiler to satisfy treesitter.
      gcc
    ];
    # Copilot needs nodejs to be in PATH. For more info see:
    # https://github.com/NixOS/nixpkgs/issues/349496
    # TODO: This can be removed once this PR is merged:
    # https://github.com/NixOS/nixpkgs/pull/350345
    extraWrapperArgs = [
      "--suffix"
      "PATH"
      ":"
      (lib.makeBinPath [ pkgs.nodejs ])
    ];
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    # Required for the Copilot plugin.
    withNodeJs = true;
  };
}
