{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Gerwin van der Lugt";
    userEmail = "account+git@gerwin3.com";
    extraConfig = {
      commit.verbose = true;
      core.editor = "vim";
      diff.algorithm = "histogram";
      fetch.prune = true;
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = false;
      rerere.enabled = true;
    };
  };
}
