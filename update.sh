#!/usr/bin/env bash

set -euo pipefail

cutoff=$(date -u -d "14 days ago" "+%Y-%m-%dT%H:%M:%SZ")
fetch_since=$(date -u -d "120 days ago" "+%Y-%m-%dT%H:%M:%SZ")

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

while read -r url; do
  repo=${url#github:}
  [[ $repo == NixOS/nixpkgs ]] && ref=nixos-unstable || ref=
  rev=$(trailing_rev "$repo" "$ref")
  sed -i -E "s#${url}(/[^\"?]*)?#${url}/${rev}#" flake.nix
done < <(rg -o 'github:[^"/?]+/[^"/?]+' flake.nix | sort -u)

nix flake update
