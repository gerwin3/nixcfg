{ pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "catppuccin"
      "dockerfile"
      "elixir"
      "git-firefly"
      "just"
      "make"
      "marksman"
      "nix"
      "rainbow-csv"
      "rust"
      "tokyo-night"
      "toml"
      "zig"
    ];
    extraPackages = with pkgs; [
      marksman
      nixd
      nixfmt
    ];
    userKeymaps = [
      # Keybindings
      #   Zed keybindings are really hard to configure:
      #   - You must idenitfy the correct context to use.
      #   - You must take into account that you can only use modifiers such as
      #     vim_mode in the context they are defined in. This can lead to some
      #     very complex expressions.
      #   - You must in addition to setting the keybind, find all places where
      #     the keybind was originally defined (default-linux.json, vim.json) and
      #     override with the exact same context.
      #   - Any update of Zed may change the default keybindings or remove
      #     contexts, or remove actions. So this is also a lot of work to
      #     maintain.
      #
      # Global bindings
      #   Note that several "global bindings" are not defined here since they
      #   only work in non editing mode. Especially the Vim-like binds need
      #   this since otherwise typing becomes impossible. They are defined
      #   later.
      {
        context = "Workspace";
        bindings = {
          "ctrl-h" = "workspace::ActivatePaneLeft";
          "ctrl-l" = "workspace::ActivatePaneRight";
          "ctrl-k" = "workspace::ActivatePaneUp";
          "ctrl-j" = "workspace::ActivatePaneDown";
        };
      }
      # Override for ctrl-h, ctrl-k, ctrl-j
      {
        context = "Editor && mode == full";
        bindings = {
          "ctrl-h" = "workspace::ActivatePaneLeft";
          "ctrl-k" = "workspace::ActivatePaneUp";
          "ctrl-j" = "workspace::ActivatePaneDown";
        };
      }
      # Override for ctrl-l
      {
        context = "Editor";
        bindings = {
          "ctrl-l" = "workspace::ActivatePaneRight";
        };
      }
      # Global Vim-like bindings
      #   These are the "global" bindings that are only active when not
      #   editing. Note that we need this stupid context query to make it work.
      #   More info here: https://github.com/zed-industries/zed/blob/main/docs/src/vim.md
      #   Note there is still an issue where these shortcuts will not work when
      #   Zed has just opened a directory and now pane is active yet ("no
      #   context"). To work around this I have a zed alias that opens README
      #   by default so that we always have an open pane.
      {
        # Ridiculous but this is the way to do it apparently.
        # Source: https://github.com/zed-industries/zed/issues/13310#issuecomment-2184930936
        # Warning: Do not put "Workspace" in here. They make the bindings work
        # in more places but will also interfere with typing in many subviews.
        context = "(Editor && (vim_mode == normal || vim_mode == visual) && !VimWaiting && !menu) || EmptyPane || SharedScreen || (ProjectPanel && not_editing)";
        bindings = {
          "space e" = "workspace::ToggleLeftDock";
          "space f f" = "file_finder::Toggle";
          "space s g" = "pane::DeploySearch";
          "space s s" = "project_symbols::Toggle";
          "space b d" = "pane::CloseActiveItem";
          "space b D" = "pane::CloseAllItems";
          # This one simulates going to the tab switcher and switching to the
          # previous tab automatically. This is very similar to space b b in
          # LazyVim.
          "space b b" = [
            "workspace::SendKeystrokes"
            "ctrl-tab enter"
          ];
          "space q q" = "workspace::CloseWindow";
          "space q Q" = "zed::Quit";
        };
      }
      # Editor bindings
      #   These are the non-Vim bindings for the editor.
      {
        context = "Editor";
        bindings = {
          "ctrl-enter" = "assistant::Assist";
        };
      }
      # Override for ctrl-enter
      {
        context = "Editor && vim_mode == full";
        bindings = {
          "ctrl-enter" = "assistant::Assist";
        };
      }
      # Editor Vim-like bindings (Normal and Visual mode)
      {
        context = "Editor && (vim_mode == normal || vim_mode == visual) && !VimWaiting && !menu";
        bindings = {
          "g r" = "editor::FindAllReferences";
          "g d" = "editor::GoToDefinition";
          "g i" = "editor::GoToImplementation";
          "g a" = "editor::ToggleCodeActions";
          "enter" = "editor::OpenExcerpts";
        };
      }
      # Editor Vim-like bindings (only Visual mode)
      {
        context = "Editor && (vim_mode == visual) && !VimWaiting && !menu";
        bindings = {
          "space a" = "assistant::InlineAssist";
          # Also need preferred_line_length = 100 in settings or it will default to 80.
          "g w" = "editor::Rewrap";
        };
      }
      # Accept completions with ctrl-y
      {
        context = "Editor && showing_completions";
        bindings = {
          "ctrl-y" = "editor::ConfirmCompletion";
        };
      }
      # Project Panel bindings
      #   These bindings only work in non_editing mode so they do not interfere
      #   with typing.
      {
        context = "ProjectPanel && not_editing";
        bindings = {
          "a" = "project_panel::NewFile";
          "shift-a" = "project_panel::NewDirectory";
          "d" = "project_panel::Delete";
          "p" = "project_panel::Paste";
          "r" = "project_panel::Rename";
          "y" = "project_panel::Copy";
          # Reverses this: https://github.com/zed-industries/zed/pull/36973
          "o" = "project_panel::OpenPermanent";
          # This keybinding is a workaround so that pressing enter inside the
          # project panel will open the file and then close the project panel
          # instead of leaving it open.
          "enter" = [
            "workspace::SendKeystrokes"
            "o space e"
          ];
        };
      }
    ];
    userSettings = {
      agent = {
        enabled = true;
        default_model = {
          provider = "copilot_chat";
          model = "gpt-4o";
        };
      };
      auto_signature_help = true;
      auto_update = false;
      buffer_font_family = "Berkeley Mono";
      buffer_font_size = 11;
      buffer_line_height = {
        custom = 1.4;
      };
      gutter = {
        line_numbers = true;
      };
      languages = {
        Nix = {
          format_on_save = {
            external = {
              command = "nixfmt";
            };
          };
          language_servers = [
            "nixd"
            "!nil"
          ];
        };
        Rust = {
          # Required for correct rewrapping behavior in Rust.
          preferred_line_length = 100;
        };
        Python = {
          show_edit_predictions = true;
          language_servers = [
            "!pylsp"
            "pyright"
            "ruff"
          ];
          format_on_save = "on";
          formatter = [
            {
              language_server = {
                name = "ruff";
              };
            }
          ];
        };
      };
      lsp = {
        marksman = {
          binary = {
            path = "${pkgs.marksman}/bin/marksman";
          };
        };
        rust-analyzer = {
          initialization_options = {
            check = {
              command = "clippy";
            };
          };
        };
      };
      show_edit_predictions = false;
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      theme = {
        mode = "system";
        light = "Catppuccin Mocha - No Italics";
        dark = "Catppuccin Mocha - No Italics";
      };
      toolbar = {
        breadcrumbs = false;
        quick_actions = false;
        selections_menu = false;
      };
      ui_font_size = 12;
      ui_font_family = "Berkeley Mono";
      vertical_scroll_margin = 20;
      vim_mode = true;
    };
  };
}
