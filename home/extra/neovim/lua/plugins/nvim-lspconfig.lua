return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        zls = {
          -- see https://github.com/zigtools/zls/blob/master/src/Config.zig
          enable_argument_placeholders = false,
          enable_build_on_save = true,
          force_autofix = true,
          warn_style = true,
        },
      }
    },
  },
}
