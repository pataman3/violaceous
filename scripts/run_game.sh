#!/bin/bash
#
# Pulls newest repository version
# Runs godot on project file

cd "${VIO_DIR}" || exit
git pull
cd game || exit
( ${GOD_BIN} )
