{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "worktree" (builtins.readFile ../scripts/worktree.sh))
  ];
}
