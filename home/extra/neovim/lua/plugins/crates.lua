return {
  {
    "saecki/crates.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup()
      local crates = require("crates")
      local opts = { silent = true }
      vim.keymap.set("n", "\\ct", crates.toggle, opts)
      vim.keymap.set("n", "\\cr", crates.reload, opts)
      vim.keymap.set("n", "\\cv", function()
        crates.show_versions_popup(); crates.focus_popup()
      end, opts)
      vim.keymap.set("n", "\\cf", function()
        crates.show_features_popup(); crates.focus_popup()
      end, opts)
      vim.keymap.set("n", "\\cd", function()
        crates.show_dependencies_popup(); crates.focus_popup()
      end, opts)
      vim.keymap.set("n", "\\cu", crates.update_crate, opts)
      vim.keymap.set("v", "\\cu", crates.update_crates, opts)
      vim.keymap.set("n", "\\ca", crates.update_all_crates, opts)
      vim.keymap.set("n", "\\cU", crates.upgrade_crate, opts)
      vim.keymap.set("v", "\\cU", crates.upgrade_crates, opts)
      vim.keymap.set("n", "\\cA", crates.upgrade_all_crates, opts)
      vim.keymap.set("n", "\\ce", crates.expand_plain_crate_to_inline_table, opts)
      vim.keymap.set("n", "\\cE", crates.extract_crate_into_table, opts)
      vim.keymap.set("n", "\\cH", crates.open_homepage, opts)
      vim.keymap.set("n", "\\cR", crates.open_repository, opts)
      vim.keymap.set("n", "\\cD", crates.open_documentation, opts)
      vim.keymap.set("n", "\\cC", crates.open_crates_io, opts)
    end,
  },
}
