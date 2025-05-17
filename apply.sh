#!/usr/bin/env bash

set -e
set -o pipefail
set -x

update=false

if [[ "$1" == "--update" ]]; then
  update=true
fi

sudo cp -r flake.nix /etc/nixos

sudo rm -rf /etc/nixos/nixos/*
sudo rm -rf /etc/nixos/home/*

sudo cp -r nixos /etc/nixos
sudo cp -r home /etc/nixos

if [[ -d "../nixcfg-priv/nixos" ]]; then
  sudo cp -r ../nixcfg-priv/nixos /etc/nixos
fi

if [[ -d "../nixcfg-priv/home" ]]; then
  sudo cp -r ../nixcfg-priv/home /etc/nixos
fi

if [[ "$update" = true ]]; then
  cd /etc/nixos
  sudo nix flake update
  cd -
fi

sudo nixos-rebuild switch
