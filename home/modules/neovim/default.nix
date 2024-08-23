{ lib, pkgs, ... }:

{
  imports = [
    ./copilot.nix
    ./nix.nix
  ];

  programs.neovim = {
    defaultEditor = true;
    enable = true;
    extraLuaConfig = lib.fileContents ./init.lua;
    plugins = [
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    ];
    viAlias = true;
    vimAlias = true;
  };
}
