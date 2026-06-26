#!/usr/bin/env bash

set -euo pipefail

cutoff=$(date -u -d "14 days ago" "+%Y-%m-%dT%H:%M:%SZ")
fetch_since=$(date -u -d "60 days ago" "+%Y-%m-%dT%H:%M:%SZ")

trailing_rev() {
  repo=$1
  ref=${2:-$(git ls-remote --symref "https://github.com/${repo}" HEAD | sed -n 's#ref: refs/heads/\(.*\)[[:space:]]HEAD#\1#p')}
  git_dir=$(mktemp -d)

  git -C "$git_dir" init -q
  git -C "$git_dir" remote add origin "https://github.com/${repo}"

  # Fetch commits since 60 days ago.
  git -C "$git_dir" fetch -q --filter=blob:none --shallow-since="$fetch_since" origin "$ref" 2>/dev/null || true
  # Find most recent commit before 14 days ago.
  commit=$(git -C "$git_dir" rev-list -n1 --before="$cutoff" FETCH_HEAD 2>/dev/null || true)

  if [[ -z $commit ]]; then
    # Fetch entire history in case there were no commits in the last 60 days.
    git -C "$git_dir" fetch -q --filter=blob:none --depth=1 origin "$ref"
    # Find most recent commit before 14 days ago.
    commit=$(git -C "$git_dir" rev-list -n1 --before="$cutoff" FETCH_HEAD 2>/dev/null || true)
  fi

  if [[ -z $commit ]]; then
    rm -rf "$git_dir"
    echo "failed to resolve ${repo}@${ref} before ${cutoff}" >&2
    exit 1
  fi

  rm -rf "$git_dir"
  echo "$commit"
}

sed -i -E "s#github:NixOS/nixpkgs(/[^\"?]*)?#github:NixOS/nixpkgs/$(trailing_rev NixOS/nixpkgs nixos-unstable)#" flake.nix
sed -i -E "s#github:numtide/flake-utils(/[^\"?]*)?#github:numtide/flake-utils/$(trailing_rev numtide/flake-utils)#" flake.nix
sed -i -E "s#github:nix-community/home-manager(/[^\"?]*)?#github:nix-community/home-manager/$(trailing_rev nix-community/home-manager)#" flake.nix
sed -i -E "s#github:NixOS/nixos-hardware(/[^\"?]*)?#github:NixOS/nixos-hardware/$(trailing_rev NixOS/nixos-hardware)#" flake.nix
sed -i -E "s#github:nix-community/impermanence(/[^\"?]*)?#github:nix-community/impermanence/$(trailing_rev nix-community/impermanence)#" flake.nix
sed -i -E "s#github:catppuccin/nix(/[^\"?]*)?#github:catppuccin/nix/$(trailing_rev catppuccin/nix)#" flake.nix

nix flake update
