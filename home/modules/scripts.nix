{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "preheat" (builtins.readFile ../scripts/preheat.sh))
    (pkgs.writeShellScriptBin "worktree" (builtins.readFile ../scripts/worktree.sh))
  ];
}
