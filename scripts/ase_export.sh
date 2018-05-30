#!/bin/bash
# Creates 2 exported files from source .ase file.

# Aseprite program location (differs per system)
ASEPRITE=/usr/bin/aseprite

get_filename () {
  echo 'Enter Aseprite filename : '
  read FILENAME
} # end of get_filename
get_filetype () {
  echo 'Enter desired filetype : '
  read FILETYPE
} # end of get_filetype

for i in "$@"
do
case $i in
    -n=*|--filename=*)
    FILENAME="${i#*=}"
    ;;
    -t=*|--filetype=*)
    FILETYPE="${i#*=}"
    ;;
esac
done

if [ "$FILENAME" == "" ]
then
  get_filename
fi
if [ "$FILETYPE" == "" ]
then
  get_filetype
fi

# Location of Aseprite files (differs per system)
FILENAME_SOURCE=/home/bryan/documents/projects/rpg/aseprite/${FILENAME}.ase

# Location for exports (differs per system)
mkdir -p /home/bryan/documents/projects/rpg/aseprite/exports/$FILENAME
EXPORTS_LOCATION=/home/bryan/documents/projects/rpg/aseprite/exports/$FILENAME

$ASEPRITE -b $FILENAME_SOURCE --save-as $EXPORTS_LOCATION/${FILENAME}.$FILETYPE
$ASEPRITE -b $FILENAME_SOURCE --scale 5 --save-as $EXPORTS_LOCATION/${FILENAME}_discord.$FILETYPE
