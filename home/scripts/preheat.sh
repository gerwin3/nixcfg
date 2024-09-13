#!/usr/bin/env bash

# Preheats all projects in ~/code and ~/code/oddity. This will run `nix develop`
# so that all further invocations of `nix develop` are faster since the
# derivations and what not will already be built :). This script runs on startup
# so when I'm done with mail and other boring stuff all code should be preheated
# and ready to!

set -e
set -o pipefail
set -x

preheat_dir () {
    dir=$1
    if [ -f "${dir}flake.nix" ] || [ -f "${dir}default.nix" ]; then
        echo "preheating $dir"
        nix develop "$dir" --command true || true
    fi
}

preheat_subdirs () {
    for dir in "$1"/*/; do
        if [ -d "$dir" ]; then
            preheat_dir "$dir"
        fi
    done
}

preheat_subdirs ~/code
preheat_subdirs ~/code/oddity
