{ ... }:

{
  programs.ncspot = {
    enable = true;
    # TODO: Does not work.
    # # FIXME: Temporarily overriding ncspot to use main since it has a fix for
    # # not being able to login. Issue is tracked here:
    # # https://github.com/hrkfdn/ncspot/issues/1500
    # package = pkgs.ncspot.override (prev: {
    #   rustPlatform = prev.rustPlatform // {
    #     buildRustPackage = args: prev.rustPlatform.buildRustPackage (args // {
    #       version = "1.1.3-dev";
    #       src = pkgs.fetchFromGitHub {
    #         owner = "hrkfdn";
    #         repo = "ncspot";
    #         rev = "f40b36741c4e3db4c50d6f055b0ad227bb3a7bfe";
    #         hash = "sha256-9HDMdd6qR/n0+cpPMi0qYcwr590gn/D5K0cXn0xeP1s=";
    #       };
    #       cargoHash = "";
    #     });
    #   };
    # });
    settings = {
      library_tabs = [ "playlists" ];
      repeat = "playlist";
      shuffle = true;
      use_nerdfont = true;
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
