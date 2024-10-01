#!/usr/bin/env bash

set -e
set -o pipefail
set -x

# This script creates a worktree for a user-selected branch. If the user passes
# a valid branch name as the first argument, a worktree is created for that
# branch, otherwise the user is prompted to select a branch. The worktree is
# created in ~/tree which is impermanent so it will be cleared on the next
# reboot.

tree_dir="${HOME}/tree"

if [[ ! -d "./.git" ]]; then
  echo "error: not a git repository"
  exit 1
fi

# Prune deleted worktress first.
git worktree prune

if [ -z "${1}" ]; then 
  # Select branch using fzf.
  branch=$(git for-each-ref --format='%(refname:short)' refs/heads/ | fzf) || return
  branch=$(echo "${branch}" | tr -d '[:space:]')
else 
  branch="${1}"
fi

branch_dirname=$(echo "${branch}" | tr '/' '-')
dest_dir="${tree_dir}/${branch_dirname}"

# Create the destination worktree if it does not exist. If it does exist, we
# skip this step and simply cd into it after.
if [ ! -d "${dest_dir}" ]; then
  mkdir -p "${dest_dir}"
  git worktree add "${dest_dir}" "${branch}"
fi

cd "${dest_dir}"
