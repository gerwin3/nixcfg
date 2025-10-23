{ ... }:

{
  programs.git = {
    enable = true;

    settings = {
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

      user = {
        name = "Gerwin van der Lugt";
        email = "account+git@gerwin3.com";
      };
    };
  };
}
