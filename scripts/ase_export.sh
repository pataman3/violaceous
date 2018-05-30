#!/bin/bash
#
# Creates 2 exported files from a source .ase file

USER=$(<user.txt)

get_filename () {
  echo 'Enter Aseprite filename : '
  read -r FILENAME
} # end of get_filename
get_filetype () {
  echo 'Enter desired filetype : '
  read -r FILETYPE
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

# TODO(bryan): Right now there is only one check to see if a flag is useless.
#   Also, we need to resolve the flags' ambiguity on the default case(s).
if [ "${FILENAME}" == "" ]
then
  get_filename
fi
if [ "${FILETYPE}" == "" ]
then
  get_filetype
fi

# TODO(bryan): Using jq and eval makes for a bit of a nasty solution. There's
#   got to be a better way around this.
ASEPRITE="jq -r '.${USER}.ase_bin' collaborators.json"
ASEPRITE=$(eval "${ASEPRITE}")

FILENAME_SOURCE="jq -r '.${USER}.ase_dir' collaborators.json"
FILENAME_SOURCE=$(eval "${FILENAME_SOURCE}")
FILENAME_SOURCE+="/${FILENAME}.ase"

EXPORTS_LOCATION="jq -r '.${USER}.ase_dir' collaborators.json"
EXPORTS_LOCATION=$(eval "${EXPORTS_LOCATION}")
EXPORTS_LOCATION+="/exports/${FILENAME}"
mkdir -p "${EXPORTS_LOCATION}"

"${ASEPRITE}" -b "${FILENAME_SOURCE}" --save-as \
  "${EXPORTS_LOCATION}"/"${FILENAME}"."${FILETYPE}"
"${ASEPRITE}" -b "${FILENAME_SOURCE}" --scale 5 --save-as \
  "${EXPORTS_LOCATION}"/"${FILENAME}"_discord."${FILETYPE}"
