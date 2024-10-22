{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "right" (builtins.readFile ../scripts/right.sh))
    (pkgs.writeShellScriptBin "preheat" (builtins.readFile ../scripts/preheat.sh))
    (pkgs.writeShellScriptBin "worktree" (builtins.readFile ../scripts/worktree.sh))
  ];
}
