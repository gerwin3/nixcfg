{ ... }:

{
  programs.swaylock = {
    enable = true;
    settings =
      let
        fg = "cdd6f4";
        bg = "1e1e2e";
        ring = "7f849c"; # overlay1
        red = "f38ba8";
        clear = "f5e0dc";
        purple = "cba6f7";
      in
      {
        color = "${bg}";
        bs-hl-color = "${red}";
        caps-lock-bs-hl-color = "${red}";
        caps-lock-key-hl-color = "${fg}";
        font = "BerkeleyMono Nerd Font";
        font-size = 32;
        indicator-idle-visible = false;
        indicator-radius = 72;
        indicator-thickness = 36;
        inside-color = "${bg}";
        inside-clear-color = "${bg}";
        inside-caps-lock-color = "${bg}";
        inside-ver-color = "${bg}";
        inside-wrong-color = "${bg}";
        key-hl-color = "${fg}";
        layout-bg-color = "${bg}";
        layout-border-color = "${bg}";
        layout-text-color = "${fg}";
        line-color = "${bg}";
        line-clear-color = "${bg}";
        line-caps-lock-color = "${bg}";
        line-ver-color = "${bg}";
        line-wrong-color = "${bg}";
        ring-color = "${ring}";
        ring-clear-color = "${clear}";
        ring-caps-lock-color = "${ring}";
        ring-ver-color = "${purple}";
        ring-wrong-color = "${red}";
        separator-color = "${ring}";
        text-color = "${fg}";
        text-clear-color = "${clear}";
        text-caps-lock-color = "${fg}";
        text-ver-color = "${purple}";
        text-wrong-color = "${red}";
      };
  };
}
