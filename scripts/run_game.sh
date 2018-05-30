#!/bin/bash
#
# Pulls newest repository version
# Runs godot on project file

USER=$(<user.txt)

# TODO(bryan): Using jq and eval makes for a bit of a nasty solution. There's
#   got to be a better way around this.
VIO_DIR="jq -r '.$USER.vio_dir' collaborators.json"
VIO_DIR=$(eval "$VIO_DIR")

cd "$VIO_DIR" || exit
git pull

cd game || exit
GOD_BIN="jq -r '.$USER.god_bin' $VIO_DIR/scripts/collaborators.json"
GOD_BIN=$(eval "$GOD_BIN")
( $GOD_BIN )
