{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "preheat" (builtins.readFile ../scripts/preheat.sh))
    (pkgs.writeShellScriptBin "wtree" (builtins.readFile ../scripts/wtree.sh))
  ];
}
