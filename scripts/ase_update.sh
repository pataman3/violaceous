#!/bin/bash
#
# Grabs all .ase files from a source and moves them into assets
# Pushes all .ase files to repository

DESTINATION=${VIO_DIR}
DESTINATION+="/assets/sprites/${USER}/"

cd "${ASE_DIR}" || exit
find . -iname '*.ase' -exec cp -r {} "${DESTINATION}" \;

cd "${VIO_DIR}" || exit
git add assets/sprites/"${USER}"/
git commit -m "Changed ${USER}'s assets"
git push origin master
