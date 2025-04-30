{ ... }:

# TODO: Switch to zsh. Have been meaning to do it for a while but no time for
# it yet. Would be cool though. I think some of the complicated terminal
# integration features below become much easier to enable. And also the prompt
# is much easier I think.

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    historyFileSize = -1;
    historySize = -1;
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
      PROMPT_COMMAND="''${PROMPT_COMMAND:+$PROMPT_COMMAND; }osc7_cwd"

      # Custom prompt
      color1="\[$(tput setaf 183)\]"
      color2="\[$(tput setaf 225)\]"
      color3="\[$(tput setaf 147)\]"
      gray="\[$(tput setaf 8)\]"
      reset="\[$(tput sgr0)\]"
      __prompt_update() {
        if [[ "$DISPLAY" == ":0" ]]; then
            if [[ -n "''${IN_NIX_SHELL}" ]]; then
              prompt_symbol="▶"
            else
              prompt_symbol=">"
            fi
            export PS1="''${color1}\t ''${color2}\h''${reset}:''${color3}\W''${gray}''${reset} ''${prompt_symbol} "
        fi
      }
      PROMPT_COMMAND="''${PROMPT_COMMAND:+$PROMPT_COMMAND; }__prompt_update"

      # Print newline before prompt except on first prompt.
      __prompt_newline() {
        if [[ -z "''${PROMPT_FIRST_TIME}" ]]; then
          PROMPT_FIRST_TIME=1
        else
          printf '\n'
        fi
      }
      PROMPT_COMMAND="''${PROMPT_COMMAND:+$PROMPT_COMMAND; }__prompt_newline"

      # Automatically load nix development shells the caveman way.
      __auto_develop() {
        if [[ "''${PWD}" == /home/gerwin/code/* ]] || [[ "''${PWD}" == /home/gerwin/tree/* ]]; then
          if [[ -f "''${PWD}/flake.nix" ]]; then
            if [[ -z "''${IN_NIX_SHELL}" ]]; then
              if grep -q "devShells" "''${PWD}/flake.nix"; then
                nix develop
                printf '\n'
              fi
            fi
          fi
        fi
      }
      PROMPT_COMMAND="''${PROMPT_COMMAND:+$PROMPT_COMMAND; }__auto_develop"
    '';
    shellAliases = {
      copy = "wl-copy";
      grep = "grep --color=auto";
      htop = "btop";
      work = "cd $(worktree)";
      zed = "zeditor --new .";
    };
    shellOptions = [
      "autocd"
      "cdspell"
      "nocaseglob"
    ];
  };
}
