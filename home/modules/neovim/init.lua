-- general
---- use system clipboard
vim.o.clipboard = "unnamedplus" ---- hide unloaded buffers
vim.o.hidden = true
---- disable stupid swap
vim.o.swapfile = false
---- disable command line when not in use
vim.o.cmdheight = 0

-- neovide --
if vim.g.neovide then
  vim.o.guifont = "Iosevka Nerd Font:h14"
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
  vim.g.neovide_scroll_animation_length = 0.1
  vim.g.neovide_cursor_animation_length = 0.02
  vim.g.neovide_cursor_trail_size = 0.1
end

-- line numbering
vim.o.relativenumber = true
vim.o.signcolumn = "number"

-- indenting
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.autoindent = true
vim.o.smartindent = true

-- formatting
vim.o.textwidth = 80 -- default textwidth
vim.o.wrap = true

-- search
---- wrap around after search EOF
vim.o.wrapscan = true

-- keybinds
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>w", "<C-w>")
vim.keymap.set("n", "<leader>c", "<C-w>c")
vim.keymap.set("n", "<leader><enter>", ":silent w<cr>")
vim.keymap.set("n", "<leader>q", ":qa<cr>")
vim.keymap.set("n", "<leader>Q", ":wqa<cr>")
vim.keymap.set("n", "<leader>G", function() require("neogit").open() end)
vim.keymap.set("n", "<ScrollWheelDown>", "j")
vim.keymap.set("n", "<ScrollWheelUp>", "k")
vim.keymap.set("n", "<A-J>", ":silent! move +1<CR>")
vim.keymap.set("n", "<A-K>", ":silent! move -2<CR>")
---- keybinds for rust
vim.keymap.set("n", "<leader><C-b>", ":!cargo build<CR>");
vim.keymap.set("n", "<leader><C-r>", ":!cargo run<CR>");
vim.keymap.set("n", "<leader>rr", ":silent CargoReload<CR>");
---- keybinds for diagnostics
vim.keymap.set("n", "]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, {})
vim.keymap.set("n", "[e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, {})
vim.keymap.set("n", "]w", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARNING }) end, {})
vim.keymap.set("n", "[w", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARNING }) end, {})
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>");
vim.keymap.set("t", "<C-d>", "<C-\\><C-n>:qa<cr>");

-- filetype overrides
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.o.shiftwidth = 2
    vim.o.tabstop = 2
  end
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "nix",
  callback = function()
    vim.o.shiftwidth = 2
    vim.o.tabstop = 2
  end
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    -- close quickfix window after selecting item
    vim.keymap.set("n", "<cr>", "<cr>:cclose<cr>",
      { noremap = true, silent = true, nowait = true, buffer = true })
  end
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown,text",
  callback = function()
    -- disable autowrapping behavior
    -- instead we want to softwrap
    vim.o.textwidth = 0
    vim.o.wrap = true
    -- and navigate on display lines rather than physical lines
    vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '0', 'g0', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '$', 'g$', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '_', 'g^', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', 'I', 'g^i', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', 'A', 'g$a', { noremap = true, silent = true })
    -- -- scroll on display lines as well (will be in neovim soon)
    -- vim.o.smoothscroll = true
  end
})

-- diagnostic
vim.diagnostic.config({ severity_sort = true })

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- plugins
require("lazy").setup({

  -- colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = false,
      })
      vim.cmd([[colorscheme catppuccin]])
    end
  },

  -- tabline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
    config = function()
      require("lualine").setup {
        options = {
          icons_enabled = true,
          theme = "auto",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = true,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      }
    end
  },

  -- fuzzy search
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require('telescope').setup({
        defaults = {
          layout_strategy = "vertical",
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {},
          },
        },
      });
      require("telescope").load_extension("ui-select");
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>b", builtin.buffers, {})
      vim.keymap.set("n", "<leader>F", builtin.find_files, {})
      vim.keymap.set("n", "<leader>f", function() builtin.git_files({ use_git_root = false }) end, {})
      vim.keymap.set("n", "<leader>g", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>sb", builtin.current_buffer_fuzzy_find, {})
      vim.keymap.set("n", "<leader>ss", builtin.lsp_document_symbols, {})
      vim.keymap.set("n", "<leader>sS", builtin.lsp_workspace_symbols, {})
      -- override some LSP commands here with telescope
      vim.keymap.set("n", "gr", builtin.lsp_references, {})
      vim.keymap.set("n", "gd", builtin.lsp_definitions, {})
      vim.keymap.set("n", "gi", builtin.lsp_implementations, {})
    end
  },

  -- fuzzy search everything
  'nvim-telescope/telescope-ui-select.nvim',

  -- language server
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    config = function()
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_lspconfig()
      lsp_zero.on_attach(
        function(client, bufnr)
          -- Disable semantic LSP highlighting (I think it sucks)
          client.server_capabilities.semanticTokensProvider = nil
          lsp_zero.default_keymaps({ buffer = bufnr })
          lsp_zero.buffer_autoformat()
          vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { noremap = true, silent = true })
        end
      )
      lsp_zero.configure("clangd", {})
      lsp_zero.configure("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } }
          }
        }
      })
      lsp_zero.configure("nil_ls", {
        settings = {
          ["nil"] = {
            formatting = {
              command = { "nixpkgs-fmt" },
            },
          }
        }
      })
      lsp_zero.configure("rust_analyzer", {
        settings = {
          ["rust-analyzer"] = {
            -- by default enable all features in LSP
            cargo = {
              buildScripts = {
                enable = true
              },
              features = "all"
            },
            -- clippy
            check = {
              command = "clippy"
            },
          }
        }
      })
      lsp_zero.configure("taplo", {})
      lsp_zero.configure("zls", {
        settings = {
          ["zls"] = {
            build_on_save_step = "check",
            enable_ast_check_diagnostics = true,
            enable_autofix = true,
            -- TODO: This has no effect for some reason. It may be that none of
            -- these options have effect actually.
            enable_build_on_save = true,
            enable_inlay_hints = true,
            enable_snippets = true,
            inlay_hints_hide_redundant_param_names = true,
            inlay_hints_hide_redundant_param_names_last_token = true,
          },
        },
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "L3MON4D3/LuaSnip" },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "copilot" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        })
      })
      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "git" },
        }, {
          { name = "buffer" },
        })
      })
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" }
        }
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" }
        }, {
          { name = "cmdline" }
        })
      })
    end
  },

  -- function signatures
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end
  },

  -- snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets"
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end
  },
  { "saadparwaiz1/cmp_luasnip" },

  -- search: stop highlighting after serach
  "romainl/vim-cool",

  -- search and replace
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Search and replace" }
    }
  },

  -- highlight word under cursor
  "RRethy/vim-illuminate",

  -- incremental rename
  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup()
    end,
  },

  -- registers
  {
    "tversteeg/registers.nvim",
    name = "registers",
    cmd = "Registers",
    keys = {
      { "\"",    mode = { "n", "v" } },
      { "<C-R>", mode = "i" }
    },
    config = {},
  },

  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        window = {
          width = 32
        },
        buffers = {
          follow_current_file = { enabled = true }
        },
        filesystem = {
          follow_current_file = { enabled = true },
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = true,
            never_show = {
              ".DS_Store",
              ".git",
              "thumbs.db"
            }
          }
        },
        event_handlers = {
          {
            event = "file_opened",
            handler = function(_)
              require("neo-tree.command").execute({ action = "close" })
            end
          }
        }
      })
      vim.keymap.set("n", "<leader>e", ":Neotree toggle<cr>")
    end
  },

  -- quick navigation
  {
    "ggandor/leap.nvim",
    config = function()
      local leap = require("leap")
      leap.add_default_mappings(true)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end
  },

  -- windows, views, etc.
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    options = {
      presets = {
        bottom_search = true,
        lsp_doc_border = true,
      },
    },
  },

  -- loading notifications
  {
    "j-hui/fidget.nvim",
    config = {},
  },

  -- terminal
  {
    "willothy/flatten.nvim",
    lazy = false,
    priority = 1001,
    config = true,
  },

  -- git
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = true
  },

  -- rust: crates
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

  -- copilot
  {
    "zbirenbaum/copilot.lua",
    lazy = false,
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = false,
          keymap = { accept = "" },
        },
        panel = { enabled = false },
      })
    end
  },

  -- copilot: cmp integration
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end
  },

})
