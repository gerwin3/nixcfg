#!/usr/bin/env bash

set -e
set -o pipefail
set -x

if [[ "$1" == "--update" ]]; then
  ./update.sh
fi

sudo cp -r flake.nix flake.lock /etc/nixos

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

sudo nixos-rebuild switch
