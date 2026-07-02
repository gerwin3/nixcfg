{
  lib,
  pkgs,
  ...
}:

let
  zedPackage = pkgs.zed-editor;

  zedBwrapLauncher = pkgs.writeShellScript "zed-bwrap-launcher" ''
    set -euo pipefail

    : "''${HOME:?HOME must be set}"
    : "''${XDG_RUNTIME_DIR:?XDG_RUNTIME_DIR must be set}"
    : "''${WAYLAND_DISPLAY:?WAYLAND_DISPLAY must be set}"

    cwd="$(pwd -P)"
    wayland_socket="''${XDG_RUNTIME_DIR}/''${WAYLAND_DISPLAY}"

    bwrap_args=(
      --new-session
      --die-with-parent
      --disable-userns
      --unshare-cgroup-try
      --unshare-ipc
      --unshare-user
      --unshare-uts
      --tmpfs "$HOME"
      --tmpfs /tmp
      --bind "$cwd" "$cwd"
      --chdir "$cwd"
      --dir "$HOME/.cache"
      --dir "$HOME/.config"
      --dir "$HOME/.local"
      --dir "$HOME/.local/share"
      --dir "$HOME/.local/share/zed"
      --dir "$HOME/.local/state"
      --dir "$XDG_RUNTIME_DIR"
      --dir /etc
      --dir /etc/static
      --dev /dev
      --dev-bind-try /dev/dri /dev/dri
      --proc /proc
      --bind-try "$HOME/.cache/fontconfig" "$HOME/.cache/fontconfig"
      --bind-try "$HOME/.cache/zed" "$HOME/.cache/zed"
      --bind-try "$HOME/.local/share/zed/agent-navigation-history.json" "$HOME/.local/share/zed/agent-navigation-history.json"
      --bind-try "$HOME/.local/share/zed/conversations" "$HOME/.local/share/zed/conversations"
      --bind-try "$HOME/.local/share/zed/db" "$HOME/.local/share/zed/db"
      --bind-try "$HOME/.local/share/zed/debug_adapters" "$HOME/.local/share/zed/debug_adapters"
      --bind-try "$HOME/.local/share/zed/extensions" "$HOME/.local/share/zed/extensions"
      --bind-try "$HOME/.local/share/zed/external_agents" "$HOME/.local/share/zed/external_agents"
      --bind-try "$HOME/.local/share/zed/hang_traces" "$HOME/.local/share/zed/hang_traces"
      --bind-try "$HOME/.local/share/zed/languages" "$HOME/.local/share/zed/languages"
      --bind-try "$HOME/.local/share/zed/logs" "$HOME/.local/share/zed/logs"
      --bind-try "$HOME/.local/share/zed/node" "$HOME/.local/share/zed/node"
      --bind-try "$HOME/.local/share/zed/prettier" "$HOME/.local/share/zed/prettier"
      --bind-try "$HOME/.local/share/zed/prompts" "$HOME/.local/share/zed/prompts"
      --bind-try "$HOME/.local/share/zed/threads" "$HOME/.local/share/zed/threads"
      --bind-try "$HOME/.local/state/zed" "$HOME/.local/state/zed"
      --bind-try "$XDG_RUNTIME_DIR/doc" "$XDG_RUNTIME_DIR/doc"
      --ro-bind /nix/store /nix/store
      --ro-bind /run/current-system /run/current-system
      --ro-bind "$wayland_socket" "$wayland_socket"
      --ro-bind-try "$HOME/.config/fontconfig" "$HOME/.config/fontconfig"
      --ro-bind-try "$HOME/.config/zed" "$HOME/.config/zed"
      --ro-bind-try "$HOME/.local/share/fonts" "$HOME/.local/share/fonts"
      --ro-bind-try "$HOME/.nix-profile" "$HOME/.nix-profile"
      --ro-bind-try "$XDG_RUNTIME_DIR/bus" "$XDG_RUNTIME_DIR/bus"
      --ro-bind-try /etc/fonts /etc/fonts
      --ro-bind-try /etc/gai.conf /etc/gai.conf
      --ro-bind-try /etc/group /etc/group
      --ro-bind-try /etc/host.conf /etc/host.conf
      --ro-bind-try /etc/hosts /etc/hosts
      --ro-bind-try /etc/localtime /etc/localtime
      --ro-bind-try /etc/nsswitch.conf /etc/nsswitch.conf
      --ro-bind-try /etc/passwd /etc/passwd
      --ro-bind-try /etc/protocols /etc/protocols
      --ro-bind-try /etc/resolv.conf /etc/resolv.conf
      --ro-bind-try /etc/services /etc/services
      --ro-bind-try /etc/ssl /etc/ssl
      --ro-bind-try /etc/pki /etc/pki
      --ro-bind-try /etc/static/pki /etc/static/pki
      --ro-bind-try /etc/static/ssl /etc/static/ssl
      --ro-bind-try /run/dbus /run/dbus
      --ro-bind-try /run/opengl-driver /run/opengl-driver
      --ro-bind-try /run/opengl-driver-32 /run/opengl-driver-32
      --ro-bind-try /run/udev /run/udev
      --ro-bind-try /sys/class/drm /sys/class/drm
      --ro-bind-try /sys/dev/char /sys/dev/char
      --ro-bind-try /sys/devices/pci0000:00 /sys/devices/pci0000:00
      --setenv HOME "$HOME"
      --setenv CURL_CA_BUNDLE /etc/ssl/certs/ca-bundle.crt
      --setenv GIT_SSL_CAINFO /etc/ssl/certs/ca-bundle.crt
      --setenv SSL_CERT_FILE /etc/ssl/certs/ca-bundle.crt
      --setenv TMPDIR /tmp
      --setenv WAYLAND_DISPLAY "$WAYLAND_DISPLAY"
      --setenv XDG_RUNTIME_DIR "$XDG_RUNTIME_DIR"
    )

    exec ${pkgs.bubblewrap}/bin/bwrap "''${bwrap_args[@]}" -- ${zedPackage}/bin/zeditor "$@"
  '';

  zedBwrapPackage = pkgs.symlinkJoin {
    name = "zed-editor-bwrap-${zedPackage.version}";
    paths = [ zedPackage ];
    preferLocalBuild = true;
    nativeBuildInputs = [ pkgs.makeWrapper ];
    meta = zedPackage.meta // {
      mainProgram = "zeditor";
    };
    postBuild = ''
      rm "$out/bin/zeditor"
      makeWrapper ${pkgs.bash}/bin/bash "$out/bin/zeditor" --add-flags ${lib.escapeShellArg zedBwrapLauncher}
    '';
  };
in
{
  programs.zed-editor = {
    enable = true;
    package = zedBwrapPackage;
    extensions = [
      "catppuccin"
      "nix"
      "tokyo-night"
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
          "space e" = "project_panel::Toggle";
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
          provider = "openai";
          model = "gpt-5.4-pro";
        };
      };
      session = {
        trust_all_worktrees = false;
      };
      project_panel = {
        dock = "left";
      };
      auto_install_extensions = {
        html = false;
      };
      auto_update_extensions = {
        html = false;
      };
      auto_signature_help = true;
      auto_update = false;
      buffer_font_family = "Berkeley Mono";
      buffer_font_size = 11;
      buffer_line_height = {
        custom = 1.4;
      };
      granted_extension_capabilities = [ ];
      gutter = {
        line_numbers = true;
      };
      languages = {
        HTML = {
          format_on_save = "off";
        };
        Nix = {
          format_on_save = "on";
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
