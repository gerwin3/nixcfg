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
        context = "Editor";
        bindings = {
          ctrl-e = "workspace::ToggleLeftDock";
        };
      }
      {
        context = "Workspace";
        bindings = {
          ctrl-e = "workspace::ToggleLeftDock";
        };
      }
    ];
    userSettings = {
      # TODO
      # assistant = {
      #   enabled = true;
      #   version = "2";
      #   default_open_ai_model = null;
      #   default_model = {
      #     provider = "zed.dev";
      #     model = "claude-3-5-sonnet-latest";
      #   };
      # };
      auto_update = false;
      base_keymap = "VSCode";
      buffer_font_family = "Berkeley Mono";
      buffer_font_size = 12;
      buffer_line_height = {
        custom = 1.4;
      };
      hour_format = "hour24";
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      theme = {
        mode = "system";
        light = "Catppuccin Mocha - No Italics";
        dark = "Catppuccin Mocha - No Italics";
      };
      ui_font_size = 12;
      ui_font_family = "Berkeley Mono";
      vertical_scroll_margin = 20;
      vim_mode = true;
    };
  };
}
