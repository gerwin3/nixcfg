{ ... }:

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
    userKeymaps = [
      {
        context = "Workspace";
        bindings = {
          "ctrl-e" = "workspace::ToggleLeftDock";
          "ctrl-f" = "file_finder::Toggle";
          "ctrl-w" = "workspace::CloseWindow";
        };
      }
      {
        context = "Workspace && vim_mode == normal";
        bindings = {
          "space e" = "workspace::ToggleLeftDock";
          "space t" = "workspace::ToggleBottomDock";
          "space f" = "file_finder::Toggle";
          "space s" = "project_search::ToggleFocus";
          "space d" = "pane::CloseActiveItem";
          "ctrl-h" = "workspace::ActivatePaneLeft";
          "ctrl-l" = "workspace::ActivatePaneRight";
          "ctrl-k" = "workspace::ActivatePaneUp";
          "ctrl-j" = "workspace::ActivatePaneDown";
        };
      }
      {
        context = "Editor";
        bindings = {
          "ctrl-h" = "workspace::ActivatePaneLeft";
          "ctrl-l" = "workspace::ActivatePaneRight";
          "ctrl-k" = "workspace::ActivatePaneUp";
          "ctrl-j" = "workspace::ActivatePaneDown";
        };
      }
      {
        context = "Editor && vim_mode == full";
        bindings = {
          "ctrl-enter" = "assistant::Assist";
        };
      }
      {
        context = "Editor && vim_mode == normal";
        bindings = {
          "space e" = "workspace::ToggleLeftDock";
          "space t" = "workspace::ToggleBottomDock";
          "space f" = "file_finder::Toggle";
          "space s" = "project_search::ToggleFocus";
          "ctrl-h" = "workspace::ActivatePaneLeft";
          "ctrl-l" = "workspace::ActivatePaneRight";
          "ctrl-k" = "workspace::ActivatePaneUp";
          "ctrl-j" = "workspace::ActivatePaneDown";
          "g r" = "editor::FindAllReferences";
          "g d" = "editor::GoToDefinition";
          "g i" = "editor::GoToImplementation";
          "g a" = "editor::ToggleCodeActions";
          "enter" = "editor::OpenExcerpts";
        };
      }
      {
        context = "Editor && vim_mode == visual";
        bindings = {
          "ctrl-a" = "assistant::QuoteSelection";
          "ctrl-i" = "assistant::InlineAssist";
          "g q" = "editor::Rewrap"
        };
      }
      {
        context = "Editor && showing_completions";
        bindings = {
          "ctrl-y" = "editor::ConfirmCompletion";
        };
      }
      {
        context = "Terminal";
        bindings = {
          "space e" = "workspace::ToggleLeftDock";
          "space t" = "workspace::ToggleBottomDock";
          "space f" = "file_finder::Toggle";
          "ctrl-h" = "workspace::ActivatePaneLeft";
          "ctrl-l" = "workspace::ActivatePaneRight";
          "ctrl-k" = "workspace::ActivatePaneUp";
          "ctrl-j" = "workspace::ActivatePaneDown";
        };
      }
      {
        context = "ProjectPanel && not_editing";
        bindings = {
          "space e" = "workspace::ToggleLeftDock";
          "space t" = "workspace::ToggleBottomDock";
          "space f" = "file_finder::Toggle";
          "ctrl-h" = "workspace::ActivatePaneLeft";
          "ctrl-l" = "workspace::ActivatePaneRight";
          "ctrl-k" = "workspace::ActivatePaneUp";
          "ctrl-j" = "workspace::ActivatePaneDown";
          "shift-a" = "project_panel::NewDirectory";
          "a" = "project_panel::NewFile";
          "d" = "project_panel::Delete";
          "y" = "project_panel::Copy";
          "v" = "project_panel::Paste";
          "r" = "project_panel::Rename";
        };
      }
    ];
    userSettings = {
      assistant = {
        enabled = true;
        version = "2";
        default_model = {
          provider = "copilot_chat";
          model = "gpt-4o";
        };
      };
      auto_signature_help = true;
      auto_update = false;
      base_keymap = "VSCode";
      buffer_font_family = "Berkeley Mono";
      buffer_font_size = 11;
      buffer_line_height = {
        custom = 1.4;
      };
      hour_format = "hour24";
      lsp = {
        rust-analyzer = {
          initialization_options = {
            check = {
              command = "clippy";
            };
          };
        };
      };
      show_edit_predictions = false;
      show_line_numbers = true;
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
