{ ... }:

{
  programs.bemenu = {
    enable = true;
    settings =
      let
        background = "#313244f2";
        foreground = "#a6adc8";
        highlight = "#b4befe";
      in
      {
        border = 16;
        border-radius = 4;
        center = true;
        ch = 18;
        cw = 2;
        fixed-height = true;
        fn = "Iosevka Nerd Font 11";
        line-height = 24;
        list = "20 down";
        no-spacing = true;
        prompt = "";
        width-factor = 0.8;
        bdr = "${background}";
        tb = "${background}";
        tf = "${foreground}";
        fb = "${background}";
        ff = "${foreground}";
        cb = "${background}";
        cf = "${foreground}";
        nb = "${background}";
        nf = "${foreground}";
        hb = "${background}";
        hf = "${highlight}";
        ab = "${background}";
        af = "${foreground}";
      };
  };
}
