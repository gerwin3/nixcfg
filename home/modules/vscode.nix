{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    profiles.default = {
      userSettings = {
        "editor.bracketPairColorization.enabled" = false;
        "editor.cursorStyle" = "line";
        "editor.detectIndentation" = false;
        "editor.fontSize" = 11;
        "editor.formatOnSave" = true;
        "editor.inlayHints.enabled" = "off";
        "editor.inlineSuggest.enabled" = true;
        "editor.insertSpaces" = true;
        "editor.lineHeight" = 1.5;
        "editor.lineNumbers" = "on";
        "editor.minimap.enabled" = false;
        "editor.minimap.maxColumn" = 80;
        "editor.rulers" = [ 100 ];
        "editor.wordWrapColumn" = 100;

        "files.exclude" = {
          "**/*.pyc" = true;
          "**/.DS_Store" = true;
          "**/.git" = true;
          "**/.hg" = true;
          "**/.idea" = true;
          "**/.svn" = true;
          "**/CVS" = true;
          "**/Thumbs.db" = true;
          "**/__pycache__" = true;
          "**/target/**" = true;
        };
        "files.watcherExclude" = {
          "**/*.pyc" = true;
          "**/.DS_Store" = true;
          "**/.git/objects/**" = true;
          "**/.git/subtree-cache/**" = true;
          "**/.hg" = true;
          "**/.idea" = true;
          "**/.svn" = true;
          "**/CVS" = true;
          "**/Thumbs.db" = true;
          "**/__pycache__" = true;
          "**/target/**" = true;
        };

        "git.autofetch" = true;
        "git.confirmSync" = false;
        "git.enableSmartCommit" = true;

        "github.copilot.editor.enableAutoCompletions" = true;
        "github.copilot.enable" = {
          "*" = false;
          "markdown" = false;
          "plaintext" = false;
          "python" = true;
          "scminput" = false;
        };
        "githubPullRequests.createOnPublishBranch" = "never";
        "githubPullRequests.pullBranch" = "never";
        "githubPullRequests.pushBranch" = "always";

        "[python]" = {
          "editor.formatOnType" = true;
          "editor.tabSize" = 4;
          "editor.wordBasedSuggestions" = false;
        };
        "python.analysis.autoImportCompletions" = false;
        "python.formatting.provider" = "black";
        "python.linting.enabled" = false;

        "redhat.telemetry.enabled" = false;

        "rust-analyzer.cargo.features" = "all";
        "rust-analyzer.check.command" = "clippy";
        "rust-analyzer.completion.autoimport.enable" = false;
        "rust-analyzer.inlayHints.enable" = false;

        "security.workspace.trust.untrustedFiles" = "open";

        "terminal.integrated.fontSize" = 12;
        "terminal.integrated.scrollback" = 100000;

        "vim.useSystemClipboard" = true;

        "window.dialogStyle" = "custom";
        "window.menuBarVisibility" = "toggle";
        "window.titleBarStyle" = "custom";
        "window.zoomLevel" = 1;
      };

      extensions = with pkgs.vscode-extensions; [
        github.copilot
        jnoortheen.nix-ide
      ];
    };
  };
}
