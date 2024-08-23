{ ... }:

{
  programs.ncspot = {
    enable = true;
    settings = {
      use_nerdfont = true;
      library_tabs = [ "playlists" ];
      # Use this handy tool to make the theme:
      # https://ncspot-theme-generator.vaa.red/
      theme = {
        background = "#1E1E2E";
        primary = "#CDD6F4";
        secondary = "#9399B2";
        title = "#B4BEFE";
        playing = "#B4BEFE";
        playing_selected = "#B4BEFE";
        playing_bg = "#00000000";
        highlight = "#CBA6F7";
        highlight_bg = "#313244";
        error = "#F5E0DC";
        error_bg = "#D20F39";
        statusbar = "#CDD6F4";
        statusbar_progress = "#B4BEFE";
        statusbar_bg = "#00000000";
        cmdline = "#CDD6F4";
        cmdline_bg = "#313244";
      };
    };
  };
}
