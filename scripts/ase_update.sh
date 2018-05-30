#!/bin/bash
#
# Grabs all .ase files from a source and moves them into assets
# Pushes all .ase files to repository

USER=$(<user.txt)

# TODO(bryan): Using jq and eval makes for a bit of a nasty solution. There's
#   got to be a better way around this.
SOURCE="jq -r '.${USER}.ase_dir' collaborators.json"
SOURCE=$(eval "${SOURCE}")

VIO_DIR="jq -r '.${USER}.vio_dir' collaborators.json"
VIO_DIR=$(eval "${VIO_DIR}")
DESTINATION=${VIO_DIR}
DESTINATION+="/assets/sprites/${USER}/"

cd "${SOURCE}" || exit
find . -iname '*.ase' -exec cp -r {} "${DESTINATION}" \;

cd "${VIO_DIR}" || exit
git add assets/sprites/"${USER}"/
git commit -m "Changed ${USER}'s assets"
git push origin master
