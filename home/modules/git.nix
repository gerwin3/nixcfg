{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Gerwin van der Lugt";
    userEmail = "account+git@gerwin3.com";
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "vim";
      push.autoSetupRemote = true;
    };
  };
}
