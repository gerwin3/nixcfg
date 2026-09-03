{ ... }:

{
  programs.fzf = {
    enable = true;

    historyWidget.options = [
      "--layout reverse"
    ];
  };
}
