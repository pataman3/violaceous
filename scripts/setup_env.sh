#!/bin/bash
#
# Establishes a COLLABORATOR's environment paths if they do not exist
# Updates a COLLABORATOR's environment paths if they exits
#
# Requirements: jq

reset
. ~/.bashrc

get_new_paths () {
  ASE_BIN="jq -r '.${COLLABORATOR}.ase_bin' collaborators.json"
  ASE_BIN=$(eval "${ASE_BIN}")
  ASE_DIR="jq -r '.${COLLABORATOR}.ase_dir' collaborators.json"
  ASE_DIR=$(eval "${ASE_DIR}")
  GOD_BIN="jq -r '.${COLLABORATOR}.god_bin' collaborators.json"
  GOD_BIN=$(eval "${GOD_BIN}")
  VIO_DIR="jq -r '.${COLLABORATOR}.vio_dir' collaborators.json"
  VIO_DIR=$(eval "${VIO_DIR}")
} # end of get_new_paths

if grep -Fxq "# Project Violaceous Environment Variables" ~/.bashrc
then
  get_new_paths

  sed -i "s@export ASE_BIN=.*@export ASE_BIN=${ASE_BIN}@" ~/.bashrc
  sed -i "s@export ASE_DIR=.*@export ASE_DIR=${ASE_DIR}@" ~/.bashrc
  sed -i "s@export GOD_BIN=.*@export GOD_BIN=${GOD_BIN}@" ~/.bashrc
  sed -i "s@export VIO_DIR=.*@export VIO_DIR=${VIO_DIR}@" ~/.bashrc

  echo "Successful in updating environment paths. Exiting..."
else
  echo "Please enter your name. : "
  read -r COLLABORATOR
  while [ ${COLLABORATOR} != "bryan" ] && [ ${COLLABORATOR} != "peter" ] && \
    [ ${COLLABORATOR} != "kyle" ]
  do
    if [ ${COLLABORATOR} == "exit" ]
    then
      echo "Unsuccessful in establishing environment paths. Exiting..."
      exit 1
    fi
    echo "Invalid COLLABORATOR. Try again or (exit)."
    read -r COLLABORATOR
  done

  get_new_paths

  echo -e "\n# Project Violaceous Environment Variables\n" >> ~/.bashrc
  echo "export COLLABORATOR=${COLLABORATOR}" >> ~/.bashrc
  echo "export ASE_BIN=${ASE_BIN}" >> ~/.bashrc
  echo "export ASE_DIR=${ASE_DIR}" >> ~/.bashrc
  echo "export GOD_BIN=${GOD_BIN}" >> ~/.bashrc
  echo "export VIO_DIR=${VIO_DIR}" >> ~/.bashrc

  echo "Successful in establishing environment paths. Exiting..."
fi
