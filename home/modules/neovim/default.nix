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
    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      copilot-cmp
      copilot-lua
      crates-nvim
      fidget-nvim
      flatten-nvim
      leap-nvim
      lsp-zero-nvim
      lsp_signature-nvim
      lualine-nvim
      luasnip
      neo-tree-nvim
      neogit
      noice-nvim
      nvim-cmp
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      registers-nvim
      telescope-nvim
      telescope-ui-select-nvim
      vim-cool
    ];
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
