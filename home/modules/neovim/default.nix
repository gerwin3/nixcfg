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
    # TODO: Currently still using init.lua but in the future this would be nice.
    # It requires also having all the config code inside Nix though, so not sure
    # if it's worth it.
    # plugins = with pkgs.vimPlugins; [
    #   catppuccin-nvim
    #   copilot-cmp
    #   copilot-lua
    #   crates-nvim
    #   fidget-nvim
    #   flatten-nvim
    #   leap-nvim
    #   lsp-zero-nvim
    #   lsp_signature-nvim
    #   lualine-nvim
    #   luasnip
    #   neo-tree-nvim
    #   neogit
    #   noice-nvim
    #   nvim-cmp
    #   nvim-lspconfig
    #   nvim-treesitter.withAllGrammars
    #   registers-nvim
    #   telescope-nvim
    #   telescope-ui-select-nvim
    #   vim-cool
    # ];
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
