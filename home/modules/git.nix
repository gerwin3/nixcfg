{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Gerwin van der Lugt";
    userEmail = "account+git@gerwin3.com";
    extraConfig = {
      branch.sort = "-committerdate";
      commit.verbose = true;
      core.editor = "vim";
      diff.algorithm = "histogram";
      diff.colorMoved = "plain";
      diff.renames = true;
      fetch.prune = true;
      fetch.pruneTags = true;
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = false;
      rerere.enabled = true;
      tag.sort = "version:refname";
    };
  };
}
