#!/bin/bash
# Grabs all .ase files from a source folder and moves them into an assets folder
# Pushes all .ase files into github

USER=$(<user.txt)

SOURCE="jq -r '.$USER.ase_dir' collaborators.json"
SOURCE=$(eval "$SOURCE")

VIO_DIR="jq -r '.$USER.vio_dir' collaborators.json"
VIO_DIR=$(eval "$VIO_DIR")
DESTINATION=$VIO_DIR
DESTINATION+="/assets/sprites/$USER/"

cd "$SOURCE" || exit
find . -iname '*.ase' -exec cp -r {} $DESTINATION \;

cd "$VIO_DIR" || exit
git add assets/sprites/$USER/
git commit -m "Changed $USER's assets"
git push origin master
