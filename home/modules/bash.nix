{ ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    historyFileSize = -1;
    historySize = -1;
    # TODO: Do not prepend newline on first prompt.
    initExtra = ''
      export EDITOR=vim
      export VISUAL=vim

      # This is required for OSC7 integration which ensures that foot can
      # determine the current directory and spawn a new shell in the same
      # directory when using the Shift+Ctrl+N combination.
      osc7_cwd() {
          local strlen=''${#PWD}
          local encoded=""
          local pos c o
          for (( pos=0; pos<strlen; pos++ )); do
              c=''${PWD:$pos:1}
              case "''$c" in
                  [-/:_.!\'\(\)~[:alnum:]] ) o="$c" ;;
                  * ) printf -v o '%%%02X' "'$c" ;;
              esac
              encoded+="''${o}"
          done
          printf '\e]7;file://%s%s\e\\' "''${HOSTNAME}" "''${encoded}"
      }
      PROMPT_COMMAND=''${PROMPT_COMMAND:+$PROMPT_COMMAND; }osc7_cwd

      # Custom prompt
      color1="\[$(tput setaf 183)\]"
      color2="\[$(tput setaf 225)\]"
      color3="\[$(tput setaf 147)\]"
      gray="\[$(tput setaf 8)\]"
      reset="\[$(tput sgr0)\]"
      # custom prompt
      if [[ "$DISPLAY" == ":0" ]]
      then
          export PS1="\n''${color1}\t ''${color2}\h''${reset}:''${color3}\W''${gray}''${reset} > "
      fi
    '';
    shellAliases = {
      copy = "wl-copy";
      grep = "grep --color=auto";
      htop = "btop";
    };
    shellOptions = [
      "autocd"
      "cdspell"
      "nocaseglob"
    ];
  };
}
