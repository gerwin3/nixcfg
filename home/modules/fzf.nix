{ ... }:

{
  programs.fzf = {
    enable = true;
    historyWidgetOptions = [
      "--layout reverse"
    ];
    catppuccin.enable = true;
  };
}
