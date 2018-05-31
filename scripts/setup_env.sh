#!/bin/bash
#
# Must be run with sudo
# Updates a user's environment paths permanently

apt-get -yq install jq

echo "Please enter your name. : "
read -r USER
while [ ${USER} != "bryan" ] && [ ${USER} != "peter" ] && \
  [ ${USER} != "kyle" ]
do
  if [ ${USER} == "exit" ]
  then
    echo "Unsuccessful in establishing environment variables. Exiting..."
    exit 1
  fi
  echo "Invalid user. Try again or (exit)."
  read -r USER
done

echo -e "\n# Project Violaceous Environment Variables\n" >> ~/.bashrc

echo "export USER=${USER}" >> ~/.bashrc

ASE_BIN="jq -r '.${USER}.ase_bin' collaborators.json"
ASE_BIN=$(eval "${ASE_BIN}")
echo "export ASE_BIN=${ASE_BIN}" >> ~/.bashrc

ASE_DIR="jq -r '.${USER}.ase_dir' collaborators.json"
ASE_DIR=$(eval "${ASE_DIR}")
echo "export ASE_DIR=${ASE_DIR}" >> ~/.bashrc

GOD_BIN="jq -r '.${USER}.god_bin' collaborators.json"
GOD_BIN=$(eval "${GOD_BIN}")
echo "export GOD_BIN=${GOD_BIN}" >> ~/.bashrc

VIO_DIR="jq -r '.${USER}.vio_dir' collaborators.json"
VIO_DIR=$(eval "${VIO_DIR}")
echo "export VIO_DIR=${VIO_DIR}" >> ~/.bashrc
