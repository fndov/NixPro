#!/bin/sh
# Automated script to install my NixPro
if [ $# -gt 0 ]
  then
    SCRIPT_DIR=$1
  else
    SCRIPT_DIR=~/.nixpro
fi

# Generate hardware config for new system
sudo nixos-generate-config --show-hardware-config > $SCRIPT_DIR/system/hardware/hardware.nix

nix-shell -p micro --run 'micro ~/.nixpro/flake.nix'

# Permissions for files that should be owned by root
# sudo $SCRIPT_DIR/harden.sh $SCRIPT_DIR
rm -rf ~/.config/ ~/.nixpro/.git/;
# Rebuild system
sudo nixos-rebuild switch --flake $SCRIPT_DIR#$(whoami);
