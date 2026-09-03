{ ... }:

{
  programs.neovim = {
    defaultEditor = true;
    enable = true;
    extraPackages = [ ];
    initLua = ''
      vim.opt.number = true
      vim.opt.cursorline = true
      vim.opt.cursorlineopt = "number"
      vim.opt.scrolloff = 10
      vim.opt.splitright = true
      vim.opt.tabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.softtabstop = 4
      vim.opt.expandtab = true
      vim.opt.smarttab = true
      vim.opt.clipboard:append('unnamedplus')
    '';
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withPython3 = false;
    withRuby = false;
  };
}
